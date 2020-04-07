
/**
 * Copyright (c) 2020-present, KiezDAO
 *
 * This source code is licensed under the Mozilla Public License, version 2,
 * found in the LICENSE file in the root directory of this source tree.
 */

pragma solidity >=0.4.21 <0.7.0;

contract Manager {
  address public cUsdAddress;
  address public toolsAddress;

	constructor (address _cUsdAddress, address _toolsAddress) public {
	  require(_cUsdAddress != address(0), "Manager: erc20 needed");
	  cUsdAddress = _cUsdAddress;
	  require(_toolsAddress != address(0), "Manager: erc721 needed");
	  toolsAddress = _toolsAddress;
	}

}
