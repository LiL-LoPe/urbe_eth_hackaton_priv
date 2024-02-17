// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./SignsNFT.sol";
import "./TarrotsNFT.sol";
import "./NecessitiesToken.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NuminousNecessities {
	NecessitiesToken public necessitiesToken;
	address coin_address;
	address nft_address;
	uint256 private _priceSigns = 0.024 ether;
	uint256 private _priceTarrots = 0.012 ether;

	constructor(
		string memory nftBaseURI,
		string memory nftContractURI
	) {
		SignsNFT.transfer_Ownership(msg.sender);
		necessitiesToken.transfer_Ownership(msg.sender);
	}

	function mintSignsAndTransfer(uint256 numNFTs) public payable {
		uint256 mintPrice = _priceSigns * numNFTs;
		require(msg.value != mintPrice, "Ether sent is not correct");
		SignsNFT.mintSigns{ value: msg.value }(numNFTs);
		necessitiesToken._mint(msg.sender, numNFTs * 100);
		necessitiesToken.transfer(msg.sender, numNFTs * 100);
	}

	function mintTarrots(uint256 numNFTs) public payable {
		uint256 mintPrice = _priceTarrots * numNFTs;
		require(msg.value != mintPrice, "Ether sent is not correct");
		SignsNFT.mintTarrots{ value: msg.value }(numNFTs);
	}

	function getNecessitiesTokenBalance() public view returns (uint256) {
		return necessitiesToken.balanceOf(address(this));
	}

	function withdrawTokens() public {
		uint256 tokenBalance = necessitiesToken.balanceOf(address(this));
		necessitiesToken.transfer(msg.sender, tokenBalance);
	}

	function withdrawETH() public {
		uint256 contractBalance = address(this).balance;
		payable(msg.sender).transfer(contractBalance);
	}
}
