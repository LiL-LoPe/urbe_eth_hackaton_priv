// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./NuminousNFT.sol";
import "./NecessitiesToken.sol";

contract NuminousNecessities {
    NuminousNFT public numinousNFT;
    NecessitiesToken public necessitiesToken;

    constructor(address _beneficiary, address _royalties, string memory _initialBaseURI, string memory _initialContractURI) {
        // Deploy the NuminousNFT contract
        numinousNFT = new NuminousNFT(_beneficiary, _royalties, _initialBaseURI, _initialContractURI);
        
        // Deploy the NecessitiesToken contract
        necessitiesToken = new NecessitiesToken();
    }

    // Mint NFTs and transfer tokens
    function mintAndTransfer(uint256 numNFTs) public payable {
        // Call the mint function in NuminousNFT contract
        numinousNFT.mint{value: msg.value}(numNFTs);

        // Call the mint function in NecessitiesToken contract
        necessitiesToken.mint(numNFTs);

        // Transfer tokens to the caller
        necessitiesToken.transfer(msg.sender, numNFTs);
    }

    // Retrieve balance of NecessitiesToken
    function getNecessitiesTokenBalance() public view returns (uint256) {
        return necessitiesToken.balanceOf(address(this));
    }

    // Withdraw tokens from the contract
    function withdrawTokens() public {
        uint256 tokenBalance = necessitiesToken.balanceOf(address(this));
        necessitiesToken.transfer(msg.sender, tokenBalance);
    }

    // Withdraw ETH from the contract
    function withdrawETH() public {
        uint256 contractBalance = address(this).balance;
        payable(msg.sender).transfer(contractBalance);
    }
}



// // SPDX-License-Identifier: MIT
// pragma solidity >=0.8.0 <0.9.0;

// import "@openzeppelin/contracts/access/Ownable.sol";
// import "./NuminousNFT.sol";
// import "./NecessitiesToken.sol";

// contract NuminousNecessities is Ownable {
//     NuminousNFT public numinousNFTContract;
//     NecessitiesToken public necessitiesTokenContract;

//     constructor(address _numinousNFTAddress, address _necessitiesTokenAddress) {
//         numinousNFTContract = NuminousNFT(_numinousNFTAddress);
//         necessitiesTokenContract = NecessitiesToken(_necessitiesTokenAddress);
//     }

//     function mintSignNFT(uint256 quantity, uint256 publicSaleKey) external payable {
//         // Mint NFT using Azuki contract
//         numinousNFTContract.publicSaleMint{value: msg.value}(quantity, publicSaleKey);

//         // Mint ERC20 tokens using NecessitiesToken contract
//         uint256 price = calculateTokenPrice(quantity); // Calculate token price based on quantity
//         require(msg.value >= price, "Insufficient ETH sent");

//         necessitiesTokenContract.mint(msg.sender, quantity);
//     }

//     function calculateTokenPrice(uint256 quantity) internal view returns (uint256) {
//         // Implement your logic to calculate the price of ERC20 tokens based on NFT quantity
//         // Example: price = quantity * tokenPrice;
//         uint256 tokenPrice = 1 ether; // Placeholder value
//         return quantity * tokenPrice;
//     }

// }

