// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NecessitiesToken is ERC20, Ownable {
	address public contractOwner;
	uint256 public maxSupply;

	constructor() ERC20("NecessitiesToken", "NCSSTKN") Ownable(msg.sender){
		maxSupply = 4200 * 10 ** uint256(decimals())
	}

	//modifier onlyOwner() {
	//	require(
	//		msg.sender == contractOwner,
	//		"Only contract owner can call this function"
	//	);
	//	_;
	//}

	function mint(address account, uint256 amount) external onlyOwner {
		require(totalSupply() + amount <= maxSupply, "Exceeds maximum supply");
		_mint(account, amount);
	}

	//function transfer_Ownership(address newOwner) external onlyOwner {
	//	require(newOwner != address(0), "Invalid address");
	//	require(
	//		msg.sender == contract_Owner,
	//		"Only contract owner can call this function"
	//);
	// 	contract_Owner = newOwner;
	// }
}
