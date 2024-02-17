// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./NuminousNFT.sol";
import "./NecessitiesToken.sol";

contract NuminousNecessities {
    NuminousNFT public numinousNFT;
    NecessitiesToken public necessitiesToken;

    constructor(
        string memory nftBaseURI,
        string memory nftContractURI,
        string memory tokenName,
        string memory tokenSymbol
    ) {
        numinousNFT = new NuminousNFT(nftBaseURI, nftContractURI);

        necessitiesToken = new NecessitiesToken();

        numinousNFT.transferOwnership(msg.sender);

        necessitiesToken.transferOwnership(msg.sender);
    }

    function mintSignAndTransfer(uint256 numNFTs) public payable {
        numinousNFT.mint{value: msg.value}(numNFTs);

        necessitiesToken.mint(numNFTs * 100);

        necessitiesToken.transfer(msg.sender, numNFTs * 100);
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