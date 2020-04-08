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

  // Mapping from token ID to value
  mapping (uint256 => uint256) private _tokenValue;

  constructor() public ERC721Full("Tool Token for KiezDAO", "KDT") MinterRole() {
  }

  /**
   * @dev Function to mint tokens.
   * @param to The address that will receive the minted token.
   * @param tokenId The token id to mint.
   * @return A boolean that indicates if the operation was successful.
   */
  function mint(address to, uint256 tokenId) public onlyMinter returns (bool) {
    _mint(to, tokenId);
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
    return true;
  }

  function burn(uint256 _tokenId) public onlyMinter returns (bool) {
    super._burn(ownerOf(_tokenId), _tokenId);
    return true;
  }
}