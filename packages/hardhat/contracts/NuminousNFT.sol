// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract NuminousNFT is ERC721, Ownable {
    using Strings for uint256;
  
	bool public isActive = false;

    uint256 constant MAX_SUPPLY_NUMINOUS = 5000;
    uint256 private _currentIdNuminous;
	string public baseURINuminous;
	string private _contractURINuminous;
    uint256 public priceNuminous = 0.25 ether;
    mapping(address => uint256) private _alreadyMintedNuminous;


    uint256 constant MAX_SUPPLY_TARROCHI = 3000;
    uint256 private _currentIdTarrochi;
    string public baseURITarrochi;
    string private _contractURITarrochi;
    uint256 public priceTarrochi = 0.1 ether;
    mapping(address => uint256) private _alreadyMintedTarrochi;

    constructor(
        string memory _initialBaseURI,
        string memory _initialContractURINuminous,

        string memory _initialBaseURITarrochi,
        string memory _initialContractURITarrochi
    ) {
        baseURINuminous = _initialBaseURINuminous;
        _contractURINuminous = _initialContractURINuminous;

        baseURITarrochi = _initialBaseURITarrochi;
        _contractURITarrochi = _initialContractURITarrochi;
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

	function mintNuminous(uint256 amount) public payable {
        require(isActiveNuminous, "Numinous minting is not active");
        require(_currentIdNuminous + amount <= MAX_SUPPLY_NUMINOUS, "Numinous will exceed maximum supply");
        require(msg.value >= priceNuminous * amount, "Insufficient ether sent for Numinous");

        for (uint256 i = 1; i <= amount; i++) {
            _currentIdNuminous++;
            _safeMint(msg.sender, _currentIdNuminous);
        }

        _alreadyMintedNuminous[msg.sender] += amount;
    }

    function mintTarrochi(uint256 amount) public payable {
        require(isActiveTarrochi, "Tarrochi minting is not active");
        require(_currentIdTarrochi + amount <= MAX_SUPPLY_TARROCHI, "Tarrochi will exceed maximum supply");
        require(msg.value >= priceTarrochi * amount, "Insufficient ether sent for Tarrochi");

        for (uint256 i = 1; i <= amount; i++) {
            _currentIdTarrochi++;
            _safeMint(msg.sender, _currentIdTarrochi);
        }

        _alreadyMintedTarrochi[msg.sender] += amount;
    }

    function withdraw() public onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }

  // Private

    function _devMintNuminous(address to, uint256 amount) private {
        require(_currentIdNuminous + amount <= MAX_SUPPLY_NUMINOUS, "Numinous will exceed maximum supply");

        for (uint256 i = 1; i <= amount; i++) {
            _currentIdNuminous++;
            _safeMint(to, _currentIdNuminous);
        }
    }
	
	function _devMintTarrochi(address to, uint256 amount) private {
  		require(_currentIdTarrochi + amount <= MAX_SUPPLY_TARROCHI, "Tarrochi will exceed maximum supply");

        for (uint256 i = 1; i <= amount; i++) {
            _currentIdTarrochi++;
            _safeMint(to, _currentIdTarrochi);
        }
    }
}