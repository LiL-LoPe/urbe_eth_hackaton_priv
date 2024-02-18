// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract TarrotsNFT is ERC721Enumerable, Ownable {
	using Strings for uint256;

	string _baseTokenURI;
	uint256 private max_supply = 4200;
	uint256 prizeTarrot = 0.012 ether;

	constructor(
		string memory baseURI
	) ERC721("Tarrots", "TRRTNFT") Ownable(msg.sender) {
		setBaseURI(baseURI);
	}

	function mintTarrots(uint256 num) external {
		uint256 supply = totalSupply();
		require(supply + num <= max_supply, "Exceeds maximum Tarrots supply");
		_safeMint(msg.sender, num * prizeTarrot);
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
}
