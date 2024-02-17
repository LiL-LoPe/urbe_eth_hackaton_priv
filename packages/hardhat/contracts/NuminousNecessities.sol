// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./NuminousNFT.sol";
import "./NecessitiesToken.sol";

contract NuminousNecessities is Ownable {
    NuminousNFT public numinousNFTContract;
    NecessitiesToken public necessitiesTokenContract;

    constructor(address _numinousNFTAddress, address _necessitiesTokenAddress) {
        numinousNFTContract = NuminousNFT(_numinousNFTAddress);
        necessitiesTokenContract = NecessitiesToken(_necessitiesTokenAddress);
    }

    function mintSignNFT(uint256 quantity, uint256 publicSaleKey) external payable {
        // Mint NFT using Azuki contract
        numinousNFTContract.publicSaleMint{value: msg.value}(quantity, publicSaleKey);

        // Mint ERC20 tokens using NecessitiesToken contract
        uint256 price = calculateTokenPrice(quantity); // Calculate token price based on quantity
        require(msg.value >= price, "Insufficient ETH sent");

        necessitiesTokenContract.mint(msg.sender, quantity);
    }

    function calculateTokenPrice(uint256 quantity) internal view returns (uint256) {
        // Implement your logic to calculate the price of ERC20 tokens based on NFT quantity
        // Example: price = quantity * tokenPrice;
        uint256 tokenPrice = 1 ether; // Placeholder value
        return quantity * tokenPrice;
    }

}