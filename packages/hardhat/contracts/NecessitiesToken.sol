// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract NecessitiesToken is ERC20 {
	uint public totalSupply;
	mapping(address => uint) public balanceOf;
	mapping(address => mapping(address => uint)) public allowance;
	string public name = "NecessitiesToken";
	string public symbol = "NCSSTKN";
	uint8 public decimals = 20;

	constructor() {
		totalSupply = 4200 * 10 ** uint(decimals);
		balanceOf[msg.sender] = totalSupply;
        contract_owner = msg.sender;
	}

}
