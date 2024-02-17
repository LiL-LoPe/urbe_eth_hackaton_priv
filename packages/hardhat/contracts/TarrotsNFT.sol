// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract TarrotsNFT is ERC721, Ownable {
	using Strings for uint256;

	string _baseTokenURI;
	uint256 private max_supply = 4200;
	//uint256 private _reserved = 4200;
	//uint256 private _priceTarrots = 0.012 ether;
	address contract_Owner;

	constructor(
		string memory baseURI
	) ERC721("Tarrots", "TRRTNFT") Ownable(msg.sender) {
		setBaseURI(baseURI);
		contract_Owner = msg.sender;
	}

	function mintTarrots(uint256 num) external onlyOwner{
		uint256 supply = totalSupply();
		require(supply + num <= max_supply, "Exceeds maximum Tarrots supply");

		// uint256 mintPrice = _priceTarrots * num;
		// require(msg.value != mintPrice, "Ether sent is not correct");

		for (uint256 i; i < num; i++) {
			_safeMint(msg.sender, supply + i);
		}
	}

	function transfer_Ownership(address newOwner) public onlyOwner {
    	require(newOwner != address(0), "Invalid address");
    	require(msg.sender == contract_Owner, "Only contract owner can call this function");
    	contract_Owner = newOwner;
	}

	function _baseURI() internal view virtual override returns (string memory) {
		return _baseTokenURI;
	}

	function setBaseURI(string memory baseURI) public onlyOwner {
		_baseTokenURI = baseURI;
	}

	function withdrawal(uint amount) external onlyOwner {
		require(amount <= address(this).balance, "Insufficient balance");
		//payable(owner()).transfer(address(this).balance);
		payable(contract_Owner).transfer(amount);
	}
}
