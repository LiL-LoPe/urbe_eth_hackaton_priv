// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./SignsNFT.sol";
import "./TarrotsNFT.sol";
import "./NecessitiesToken.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NuminousNecessities is Ownable{
	address coin_address;
	address nft_address;
	uint256 private _priceSigns = 0.024 ether;
	uint256 private _priceTarrots = 0.012 ether;
	bool initialized;
	SignsNFT signsNFT;
	NecessitiesToken necessitiesToken;
	TarrotsNFT tarrotsNFT;

	constructor(
		string memory nftBaseURI,
		string memory nftContractURI
	) Ownable(msg.sender) {
		//SignsNFT.transfer_Ownership(msg.sender);
		//NecessitiesToken.transfer_Ownership(msg.sender);
	}

	function init(address _signNFTContractAddress, address _necessitiesTokenContractAddress, address _tarrotsNFTContractAddress) external {
		require(!initialized);
		signsNFT = SignsNFT(_signNFTContractAddress);
		necessitiesToken = NecessitiesToken(_necessitiesTokenContractAddress);
		tarrotsNFT = TarrotsNFT(_tarrotsNFTContractAddress);
		initialized = true;

	}

	function mintSignsAndTransfer(uint256 numNFTs) public payable {
		uint256 mintPrice = _priceSigns * numNFTs;
		require(msg.value != mintPrice, "Ether sent is not correct");
		signsNFT.mintSigns(numNFTs);
		necessitiesToken.mint(msg.sender, numNFTs * 100);
		necessitiesToken.transfer(msg.sender, numNFTs * 100);
	}

	function mintTarrots(uint256 numNFTs) public payable {
		uint256 mintPrice = _priceTarrots * numNFTs;
		require(msg.value != mintPrice, "Ether sent is not correct");
		tarrotsNFT.mintTarrots(numNFTs);
	}

	function getNecessitiesTokenBalance() public view returns (uint256) {
		return necessitiesToken.balanceOf(address(this));
	}

	function withdrawTokens() public onlyOwner{
		uint256 tokenBalance = necessitiesToken.balanceOf(address(this));
		necessitiesToken.transfer(msg.sender, tokenBalance);
	}

	function withdrawETH() public onlyOwner {
		uint256 contractBalance = address(this).balance;
		payable(msg.sender).transfer(contractBalance);
	}
}
