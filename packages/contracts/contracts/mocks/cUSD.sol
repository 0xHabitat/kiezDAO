pragma solidity ^0.5.0;

import "../../node_modules/openzeppelin-solidity/contracts/token/ERC20/ERC20Mintable.sol";
import "../../node_modules/openzeppelin-solidity/contracts/token/ERC20/ERC20Detailed.sol";

contract CUSD is ERC20Mintable, ERC20Detailed {

	constructor () public ERC20Detailed("Celo USD", "cusd", 19) {
	// solhint-disable-previous-line no-empty-blocks
	}

	function removeMinter(address account) public {
    _removeMinter(account);
	}

	// Causes a compilation error if super._removeMinter is not internal
	function _removeMinter(address account) internal {
    super._removeMinter(account);
	}
}