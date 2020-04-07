
/**
 * Copyright (c) 2020-present, KiezDAO
 *
 * This source code is licensed under the Mozilla Public License, version 2,
 * found in the LICENSE file in the root directory of this source tree.
 */

pragma solidity >=0.4.21 <0.7.0;

contract Manager {
  address public owner;

  function setOwner() public {
    owner = msg.sender;
  }
}
