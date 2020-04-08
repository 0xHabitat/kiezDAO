
/**
 * Copyright (c) 2020-present, KiezDAO
 *
 * This source code is licensed under the Mozilla Public License, version 2,
 * found in the LICENSE file in the root directory of this source tree.
 */

pragma solidity >=0.4.21 <0.7.0;

import "./ToolsToken.sol";
import "./mocks/CUSD.sol";

contract Manager {

  event Publication(uint256 indexed toolId, address indexed lender, uint256 value);
  event Withdrawal(uint256 indexed toolId, address indexed lender);

  event Request(uint256 indexed toolId, address indexed borrower);
  event CancelRequest(uint256 indexed toolId, address indexed borrower);

  event Issuance(uint256 indexed toolId, address indexed lender, address indexed borrower);
  event Restition(uint256 indexed toolId, address indexed lender, address indexed borrower);


  CUSD public cUSD;
  ToolsToken public tools;
  address public community;

  struct Issue {
    uint256 toolId;
    address borrower; // the guy that wants the tool to do something
  }

  // Mapping from issueId(toolId + lender address) to issue
  mapping (bytes32 => Issue) public issues;

  struct Offer {
    bool issued;
    address lender; // the dude that has the tool and offers it
    uint256 value;
  }

  // Mapping from toolId to offers
  mapping (uint256 => Offer) public offers;

  constructor (address _cUsdAddress, address _toolsAddress, address _community) public {
    require(_cUsdAddress != address(0), "Manager: erc20 needed");
    cUSD = CUSD(_cUsdAddress);
    require(_toolsAddress != address(0), "Manager: erc721 needed");
    tools = ToolsToken(_toolsAddress);
    community = _community;
  }

  function publishTool(uint256 toolId, uint256 value) public {
    tools.transferFrom(msg.sender, address(this), toolId);
    offers[toolId] = Offer(false, msg.sender, value);
  }

  function withdrawTool(uint256 toolId) public {
    Offer memory offer = offers[toolId];
    require(offer.issued == false, "Manager: not available");
    require(offer.lender == msg.sender, "Manager: not lender");
    tools.transferFrom(address(this), offer.lender, toolId);
    delete offers[toolId];
  }

  function request(uint256 toolId) public {
    require(tools.ownerOf(toolId) == address(this), "Mnaager: not published");
    // transfer stake + fee + contriubiotn
    uint256 depositSize = offers[toolId].value * 12 / 10;
    require(cUSD.transferFrom(msg.sender, address(this), depositSize), "Manager: payment failed");

    // record issue
    bytes32 issueId = keccak256(abi.encode(toolId, msg.sender));
    issues[issueId] = Issue(toolId, msg.sender);

    emit Request(toolId, msg.sender);
  }


  function cancelRequest(uint256 toolId) public {
    bytes32 issueId = keccak256(abi.encode(toolId, msg.sender));
    require(issues[issueId].toolId == toolId, "Manager: not requested");
    delete issues[issueId];
    uint256 depositSize = offers[toolId].value * 12 / 10;
    cUSD.transfer(tools.ownerOf(toolId), depositSize);
    emit CancelRequest(toolId, msg.sender);
  }

  // own memory management without allocation
  function safer_ecrecover(bytes32 hash, uint8 v, bytes32 r, bytes32 s) internal returns (bool, address) {
    // NOTE: inline assembly won't access return values
    bool ret;
    address addr;

    assembly {
      let size := mload(0x40)
      mstore(size, hash)
      mstore(add(size, 32), v)
      mstore(add(size, 64), r)
      mstore(add(size, 96), s)

      // NOTE: the request memory can be reused because for the return code
      ret := call(3000, 1, 0, size, 128, size, 32)
      addr := mload(size)
    }

    return (ret, addr);
  }

  function issue(uint256 toolId, uint8 v, bytes32 r, bytes32 s) public {
    require(tools.ownerOf(toolId) == address(this), "Manager: unpublished is unconfirmable");
    bool success;
    address signer; // signature of borrower
    (success, signer) = safer_ecrecover(bytes32(toolId), v, r, s);
    require(success == true, "recover failed");

    bytes32 issueId = keccak256(abi.encode(toolId, signer));
    require(issues[issueId].toolId == toolId, "Manager: not signed by borrower");
    offers[toolId].issued = true;
    emit Issuance(toolId, msg.sender, signer);
  }

  function restitute(uint256 toolId, uint8 v, bytes32 r, bytes32 s) public {
    // check caller
    bytes32 issueId = keccak256(abi.encode(toolId, msg.sender));
    Issue memory issue = issues[issueId];
    require(issue.toolId == toolId, "Manager: return only by borrower");
    // check sig of lender
    bool success;
    address signer;
    (success, signer) = safer_ecrecover(bytes32(toolId), v, r, s);
    require(success == true, "recover failed");

    // check offer is issued, and then reset
    Offer memory offer = offers[toolId];
    require(offer.lender == signer, "Manager: lender sig failed");
    require(offer.issued == true, "Manager: already returned");
    offers[toolId].issued = false;
    // return tool
    tools.transferFrom(address(this), offer.lender, toolId);
    // pay fee
    cUSD.transfer(offer.lender, offer.value / 12);
    // pay community
    cUSD.transfer(community, offer.value / 12);
    // return stake
    cUSD.transfer(issue.borrower, offer.value * 10 / 12);
    delete issues[issueId];
    emit Restition(toolId, offer.lender, issue.borrower);
  }

}
