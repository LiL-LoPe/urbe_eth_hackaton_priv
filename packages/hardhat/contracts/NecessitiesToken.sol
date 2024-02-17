// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract NecessitiesToken is ERC20 {
	uint public totalSupply;
	mapping(address => uint) public balanceOf;
	mapping(address => mapping(address => uint)) public allowance;
	string public name = "NecessitiesToken";
	string public symbol = "NCSSTKN";
	uint8 public decimals = 20;
    address contract_owner;

	constructor() {
		totalSupply = 4200 * 10 ** uint(decimals);
		balanceOf[msg.sender] = totalSupply;
        contract_owner = msg.sender;
	}

        modifier onlyOwner() {
        require(msg.sender == contract_owner, "Only contract owner can call this function");
        _;
    }

    function withdrawal(uint amount) public onlyOwner {
        require(amount <= address(this).balance, "Insufficient balance");
        //payable(owner()).transfer(address(this).balance);
        payable(contract_owner).transfer(amount);
    }

}