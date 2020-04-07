
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

	event Request(uint256 indexed toolId, address indexed borrower);
	event CancelRequest(uint256 indexed toolId, address indexed borrower);

  CUSD public cUSD;
  ToolsToken public tools;

  struct Issue {
  	uint256 tokenId;
  	address borrower;
  }

  // Mapping from token ID to value
  mapping (bytes32 => Issue) public issues;

	constructor (address _cUsdAddress, address _toolsAddress) public {
	  require(_cUsdAddress != address(0), "Manager: erc20 needed");
	  cUSD = CUSD(_cUsdAddress);
	  require(_toolsAddress != address(0), "Manager: erc721 needed");
	  tools = ToolsToken(_toolsAddress);
	}


  function request(uint256 tokenId) public {
    require(tools.getApproved(tokenId) == address(this), "ToolsToken: not published");
    // transfer stake + fee + contriubiotn
    uint256 toolValue = tools.valueOf(tokenId);
    require(cUSD.transferFrom(msg.sender, address(this), toolValue * 12 / 10), "ToolsToken: payment failed");
    
    // record issue
    bytes32 issueId = keccak256(abi.encode(tokenId, msg.sender));
    issues[issueId] = Issue(tokenId, msg.sender);

    emit Request(tokenId, msg.sender);
  }


  function cancelRequest(uint256 tokenId) public {
  	bytes32 issueId = keccak256(abi.encode(tokenId, msg.sender));
    require(issues[issueId].tokenId == tokenId, "ToolsToken: no issue");
    delete issues[issueId];
    uint256 toolValue = tools.valueOf(tokenId);
    cUSD.transfer(tools.ownerOf(tokenId), toolValue * 12/ 10);
    emit CancelRequest(tokenId, msg.sender);
  }

}
