// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

// Useful for debugging. Remove when deploying to a live network.
import "hardhat/console.sol";

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract NuminousNecessities is ERC1155 {
    using Strings for uint256;

    
    uint256 public constant TarotsCollection = 1;
    uint256 public constant SignsCollection = 2;
    uint256 public constant TokenCollection = 3;

    
    mapping(address => uint256) public mintedTarots;
    mapping(address => uint256) public mintedSigns;
    mapping(address => uint256) public mintedTokens;

    
    uint256 public constant TarotsPrice = 0.01 ether;
    uint256 public constant SignsPrice = 0.005 ether;

    constructor() ERC1155("https://ipfs.io/ipfs/bafybeihjjkwdrxxjnuwevlqtqmh3iegcadc32sio4wmo7bv2gbf34qs34a/{id}.json") {
 
        _mint(msg.sender, TarotsCollection, 22, "");
        _mint(msg.sender, SignsCollection, 12, "");
        _mint(msg.sender, NuminousToken, 1200, "");
    }


    function mintTarot() external payable {
        require(msg.value >= TarotsPrice, "Insufficient funds");


        mintedTarots[msg.sender]++;

        
        _mint(msg.sender, TarotsCollection, mintedTarots[msg.sender], "");
    }

    function mintSign() external payable {
        require(mintedTarots[msg.sender] > 0, "You must own at least one Tarot to mint a Sign");
        require(msg.value >= SignsPrice, "Insufficient funds");

        mintedSigns[msg.sender]++;


        _mint(msg.sender, SignsCollection, mintedSigns[msg.sender], "");
    }

}


 //function mintTarot() external payable {
 //       require(msg.value >= TarotsPrice, "Insufficient funds");
//
 //       // Incremento del contatore dei Tarots mintati per l'indirizzo del mittente
 //       mintedTarots[msg.sender]++;
//
 //       // Mint del nuovo NFT della collezione Tarots
 //       _mint(msg.sender, TarotsCollection, mintedTarots[msg.sender], "");
//
 //       // Mint contemporaneo di un certo numero di token Numinous
 //       _mint(msg.sender, NuminousToken, 5, "");
 //       mintedNuminous[msg.sender] += 5;
 //   }
//
 //   // Funzione per mintare un token dalla collezione Numinous
 //   function mintNuminous() external payable {
 //       require(msg.value >= TokenPrice, "Insufficient funds");
//
 //       // Incremento del contatore dei Token mintati per l'indirizzo del mittente
 //       mintedNuminous[msg.sender]++;
//
 //       // Mint del nuovo token dalla collezione Numinous
 //       _mint(msg.sender, NuminousToken, 1, "");
 //   }
//}