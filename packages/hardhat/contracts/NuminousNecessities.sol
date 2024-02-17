// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./SignsNFT.sol";
import "./TarrotsNFT.sol";
import "./NecessitiesToken.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract NuminousNecessities {
	NuminousNFT public numinousNFT;
	NecessitiesToken public necessitiesToken;
	address coin_address;
	address nft_address;
	uint256 private _priceSigns = 0.024 ether;
	uint256 private _priceTarrots = 0.012 ether;

	constructor(
		string memory nftBaseURI,
		string memory nftContractURI,
		//string memory tokenName,
		//string memory tokenSymbol
	) {
		//numinousNFT = new NuminousNFT(nftBaseURI /*, nftContractURI*/);
		//necessitiesToken = new NecessitiesToken();
		numinousNFT.transfer_Ownership(msg.sender);
		necessitiesToken.transfer_Ownership(msg.sender);
	}

	function mintSignsAndTransfer(uint256 numNFTs) public payable {
		uint256 mintPrice = _priceSigns * num;
		require(msg.value != mintPrice, "Ether sent is not correct");
		numinousNFT.mintSigns{ value: msg.value }(numNFTs);
		necessitiesToken._mint(numNFTs * 100);
		necessitiesToken.transfer(msg.sender, numNFTs * 100);
	}

	function mintTarrots(uint256 numNFTs) public payable {
		uint256 mintPrice = _priceTarrots * num;
		require(msg.value != mintPrice, "Ether sent is not correct");
		numinousNFT.mintTarrots{ value: msg.value }(numNFTs);
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
    
    function transferOwnershipOfContracts(address newOwner) public {
    require(msg.sender == owner(), "Only contract owner can call this function");
    
    numinousNFT.transferOwnership(newOwner);
    necessitiesToken.transferOwnership(newOwner);
    signsNFT.transferOwnership(newOwner);
    tarrotsNFT.transferOwnership(newOwner);
}
}
