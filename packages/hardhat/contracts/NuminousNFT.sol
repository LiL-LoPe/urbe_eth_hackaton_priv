// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import { IERC2981, IERC165 } from "@openzeppelin/contracts/interfaces/IERC2981.sol";

contract NuminousNFT is ERC721, Ownable {
    using Strings for uint256;

    uint256 constant MAX_SUPPLY = 5000;
    uint256 private _currentId;

    string public baseURI;
    string private _contractURI;

    bool public isActive = false;

    uint256 public price = 0.25 ether;

    mapping(address => uint256) private _alreadyMinted;

    constructor(
        string memory _initialBaseURI,
        string memory _initialContractURI
    ) ERC721("NuminousNFT", "NMNSNFT") {
        baseURI = _initialBaseURI;
        _contractURI = _initialContractURI;
    }

    // Accessors

    function setActive(bool _isActive) public onlyOwner {
        isActive = _isActive;
    }

    function alreadyMinted(address addr) public view returns (uint256) {
        return _alreadyMinted[addr];
    }

    function totalSupply() public view returns (uint256) {
        return _currentId;
    }

    // Metadata

    function setBaseURI(string memory uri) public onlyOwner {
        baseURI = uri;
    }

    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }

    function contractURI() public view returns (string memory) {
        return _contractURI;
    }

    function setContractURI(string memory uri) public onlyOwner {
        _contractURI = uri;
    }

    // Minting

    function mint(uint256 amount) public payable {
        require(isActive, "Minting is not active");
        require(_currentId + amount <= MAX_SUPPLY, "Will exceed maximum supply");
        require(msg.value >= price * amount, "Insufficient ether sent");

        for (uint256 i = 1; i <= amount; i++) {
            _currentId++;
            _safeMint(msg.sender, _currentId);
        }

        _alreadyMinted[msg.sender] += amount;
    }

    function withdraw() public onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }

    // Private

    function _internalMint(address to, uint256 amount) private {
        require(_currentId + amount <= MAX_SUPPLY, "Will exceed maximum supply");

        for (uint256 i = 1; i <= amount; i++) {
            _currentId++;
            _safeMint(to, _currentId);
        }
    }
}
