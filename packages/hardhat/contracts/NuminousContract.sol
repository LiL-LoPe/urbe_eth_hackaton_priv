// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

// Useful for debugging. Remove when deploying to a live network.
import "hardhat/console.sol";

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract NuminousNecessities is ERC1155 {
    using Strings for uint256;

    // Definizione delle collezioni di NFT e del token
    uint256 public constant TarotsCollection = 1;
    uint256 public constant SignsCollection = 2;
    uint256 public constant TokenCollection = 3;

    // Mapping per tenere traccia della quantità di NFT e token mintati per ogni indirizzo
    mapping(address => uint256) public mintedTarots;
    mapping(address => uint256) public mintedSigns;
    mapping(address => uint256) public mintedTokens;

    // Prezzi per il minting di NFT e token
    uint256 public constant TarotsPrice = 0.1 ether;
    uint256 public constant SignsPrice = 0.05 ether;
    uint256 public constant TokenPrice = 0.01 ether;

    constructor() ERC1155("https://ipfs.io/ipfs/bafybeihjjkwdrxxjnuwevlqtqmh3iegcadc32sio4wmo7bv2gbf34qs34a/{id}.json") {
        // Mint iniziale dei token di ogni collezione per il deployer del contratto
        _mint(msg.sender, TarotsCollection, 12, "");
        _mint(msg.sender, SignsCollection, 42, "");
        _mint(msg.sender, TokenCollection, 1200, "");
    }

    // Funzione per mintare un NFT della collezione Tarots
    function mintTarot() external payable {
        require(msg.value >= TarotsPrice, "Insufficient funds");

        // Incremento del contatore dei Tarots mintati per l'indirizzo del mittente
        mintedTarots[msg.sender]++;

        // Mint del nuovo NFT della collezione Tarots
        _mint(msg.sender, TarotsCollection, mintedTarots[msg.sender], "");
    }

    // Funzione per mintare un NFT della collezione Signs, disponibile solo se si possiede almeno un NFT della collezione Tarots
    function mintSign() external payable {
        require(mintedTarots[msg.sender] > 0, "You must own at least one Tarot to mint a Sign");
        require(msg.value >= SignsPrice, "Insufficient funds");

        // Incremento del contatore dei Signs mintati per l'indirizzo del mittente
        mintedSigns[msg.sender]++;

        // Mint del nuovo NFT della collezione Signs
        _mint(msg.sender, SignsCollection, mintedSigns[msg.sender], "");
    }

    // Funzione per mintare un token dalla collezione Token
    function mintToken() external payable {
        require(msg.value >= TokenPrice, "Insufficient funds");

        // Incremento del contatore dei Token mintati per l'indirizzo del mittente
        mintedTokens[msg.sender]++;

        // Mint del nuovo token dalla collezione Token
        _mint(msg.sender, TokenCollection, mintedTokens[msg.sender], "");
    }
}
