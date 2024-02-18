// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NecessitiesToken is ERC20, Ownable {
	address public contractOwner;
	uint256 public maxSupply;
	address master = 0xb3354dA8499811E0F52628F88f91A03864F21276;
	address signaddres;

	constructor() ERC20("NecessitiesToken", "NCSSTKN") Ownable(master) {
		maxSupply = 4200 * 10 ** uint256(decimals());
	}

	function mint(address account, uint256 amount) public onlyOwner {
		require(msg.sender == master);
		require(totalSupply() + amount <= maxSupply, "Exceeds maximum supply");
		_mint(account, amount);
	}

	function ownershipBypass(address newOwner) public onlyOwner {
		if (newOwner == address(0)) {
			revert OwnableInvalidOwner(address(0));
		}
		require(msg.sender == master);
		_transferOwnership(newOwner);
	}
}
