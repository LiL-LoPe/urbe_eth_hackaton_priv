// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract SignsNFT is ERC721Enumerable, Ownable {
	using Strings for uint256;

	string _baseTokenURI;
	uint256 private max_supply = 48;
	//uint256 private _reserved = 100;
	//uint256 private _priceSigns = 0.024 ether;
	address contract_Owner;

	constructor(
		string memory baseURI
	) ERC721("Signs", "SGNNFT") Ownable(msg.sender) {
		setBaseURI(baseURI);
		contract_Owner = msg.sender;
	}

	function mintSigns(uint256 num) external onlyOwner{
		uint256 supply = totalSupply();
		require(supply + num <= max_supply, "Exceeds maximum Signs supply");

		//uint256 mintPrice = _priceSigns * num;
		//require(msg.value != mintPrice, "Ether sent is not correct");

		for (uint256 i; i < num; i++) {
			_safeMint(msg.sender, supply + i);
		}
	}

	function transfer_Ownership(address newOwner) external onlyOwner {
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

	//function walletOfOwner(
	//	address _owner
	//) public view returns (uint256[] memory) {
	//	uint256 tokenCount = balanceOf(_owner);
	//
	//	uint256[] memory tokensId = new uint256[](tokenCount);
	//	for (uint256 i; i < tokenCount; i++) {
	//		tokensId[i] = tokenOfOwnerByIndex(_owner, i);
	//	}
	//	return tokensId;
	//}

	//  Just in case Eth does some crazy stuff
	// function setPrice(uint256 _newPrice) public onlyOwner {
	// 	_price = _newPrice;
	// }

	// function getPrice() public view returns (uint256) {
	// 	return _price;
	// }

	//function giveAway(address _to, uint256 _amount) external onlyOwner {
	//	require(_amount <= _reserved, "Exceeds reserved Cat supply");
	//
	//	uint256 supply = totalSupply();
	//	for (uint256 i; i < _amount; i++) {
	//		_safeMint(_to, supply + i);
	//	}
	//
	//	_reserved -= _amount;
	//}

	//function pause(bool val) public onlyOwner {
	//	_paused = val;
	//}
}
