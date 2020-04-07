pragma solidity >=0.4.21 <0.7.0;

contract Renting {
  address public owner;

  function setOwner() public {
    owner = msg.sender;
  }
}
