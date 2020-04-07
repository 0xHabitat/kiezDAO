/**
 * Copyright (c) 2020-present, KiezDAO
 *
 * This source code is licensed under the Mozilla Public License, version 2,
 * found in the LICENSE file in the root directory of this source tree.
 */

pragma solidity >=0.4.21 <0.7.0;

import "../node_modules/openzeppelin-solidity/contracts/token/ERC721/ERC721Full.sol";
import "../node_modules/openzeppelin-solidity/contracts/access/roles/MinterRole.sol";

/**
 * @title ToolsToken
 * @dev Simple ERC721 token mintable by whitelisted accounts
 */

contract ToolsToken is ERC721Full, MinterRole {

  event Issuance(address indexed from, address indexed to, uint256 indexed tokenId);

  // Mapping from token ID to Proprietor
  mapping (uint256 => address) private _tokenProprietor;

  // Mapping from token ID to value
  mapping (uint256 => uint256) private _tokenValue;

  constructor() public ERC721Full("Tool Token for KiezDAO", "KDT") MinterRole() {
  }

  /**
   * @dev Gets the Proprietor of the specified token ID.
   * @param tokenId uint256 ID of the token to query the Proprietor of
   * @return address currently marked as the Proprietor of the given token ID
   */
  function proprietorOf(uint256 tokenId) public view returns (address) {
    address proprietor = _tokenProprietor[tokenId];
    require(proprietor != address(0), "ToolsToken: proprietor query for nonexistent token");

    return proprietor;
  }

  /**
   * @dev Gets the value of the specified token ID.
   * @param tokenId uint256 ID of the token to query the value of
   * @return uint256 value of the given token ID
   */
  function valueOf(uint256 tokenId) public view returns (uint256) {
    return _tokenValue[tokenId];
  }

  function setValue(uint256 tokenId, uint256 value) public {
    require(ownerOf(tokenId) == msg.sender, "ToolsToken: not owner");
    _tokenValue[tokenId] = value; 
  }

  /**
   * @dev Function to mint tokens.
   * @param to The address that will receive the minted token.
   * @param tokenId The token id to mint.
   * @return A boolean that indicates if the operation was successful.
   */
  function mint(address to, uint256 tokenId) public onlyMinter returns (bool) {
    _mint(to, tokenId);
    _tokenProprietor[tokenId] = to;
    return true;
  }

  /**
   * @dev Function to safely mint tokens.
   * @param to The address that will receive the minted token.
   * @param tokenId The token id to mint.
   * @return A boolean that indicates if the operation was successful.
   */
  function safeMint(address to, uint256 tokenId) public onlyMinter returns (bool) {
    _safeMint(to, tokenId);
    _tokenProprietor[tokenId] = to;
    return true;
  }

  /**
   * @dev Function to safely mint tokens.
   * @param to The address that will receive the minted token.
   * @param tokenId The token id to mint.
   * @param _data bytes data to send along with a safe transfer check.
   * @return A boolean that indicates if the operation was successful.
   */
  function safeMint(address to, uint256 tokenId, bytes memory _data) public onlyMinter returns (bool) {
    _safeMint(to, tokenId, _data);
    _tokenProprietor[tokenId] = to;
    return true;
  }

  /**
   * @dev Modifier to make a function callable only when the token is not lent out.
   */
  modifier whenNotLent(uint256 _tokenId) {
      require(ownerOf(_tokenId) == _tokenProprietor[_tokenId], "ToolsToken: lent");
      _;
  }

  function approve(address to, uint256 tokenId) public whenNotLent(tokenId) {
    super.approve(to, tokenId);
  }

  function _transferFrom(address from, address to, uint256 tokenId) internal whenNotLent(tokenId) {
    super._transferFrom(from, to, tokenId);
  }

  function burn(uint256 _tokenId) public onlyMinter returns (bool) {
    super._burn(ownerOf(_tokenId), _tokenId);
    delete _tokenProprietor[_tokenId];
    return true;
  }
}