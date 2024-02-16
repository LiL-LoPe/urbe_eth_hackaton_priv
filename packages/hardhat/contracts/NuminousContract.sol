// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

// Useful for debugging. Remove when deploying to a live network.
import "hardhat/console.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "./ERC721A.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract NuminousNecessities is Ownable, ERC1155 {
    using Strings for uint256;

    address contract_owner;

    string private _baseTokenURI;

    uint256 public constant TarotsCollection = 1;
    uint256 public constant SignsCollection = 2;
    uint256 public constant NuminousToken = 3;

    uint256 private _status;

    struct TokenOwnership {
        address addr;
        uint64 startTimestamp;
    }

    mapping(address => uint256) public mintedTarots;
    mapping(address => uint256) public mintedSigns;
    mapping(address => uint256) public mintedTokens;
    mapping(address => bool) public hasSign;
    mapping(address => bool) public hasMintedSign;

    
    uint256 public constant TarotsPrice = 0.01 ether;
    uint256 public constant SignsPrice = 0.005 ether;

    constructor(uint256 collectionSize_) ERC1155("https://ipfs.io/ipfs/bafybeihjjkwdrxxjnuwevlqtqmh3iegcadc32sio4wmo7bv2gbf34qs34a/{id}.json") {
        
        contract_owner = msg.sender;
        _mint(msg.sender, TarotsCollection, 22, "");
        _mint(msg.sender, SignsCollection, 12, "");
        _mint(msg.sender, NuminousToken, 1200, "");
    }

    modifier callerIsUser() {
        require(tx.origin == msg.sender, "The caller is another contract");
        _;
    }

    function refundIfOver(uint256 price) private {
        require(msg.value >= price, "Need to send more ETH.");
        if (msg.value > price) {
            payable(msg.sender).transfer(msg.value - price);
        }
    }

    function withdrawMoney() external onlyOwner {
        (bool success, ) = msg.sender.call{value: address(this).balance}("");
        require(success, "Transfer failed.");
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }

    function setBaseURI(string calldata baseURI) external onlyOwner {
        _baseTokenURI = baseURI;
    }

    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _setOwner(newOwner);
    }

    function _setOwner(address newOwner) private {
        address oldOwner = contract_owner;
        contract_owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }

    function getOwnershipData(uint256 tokenId)
        external view
        returns (TokenOwnership memory)
    {
        return ownershipOf(tokenId);
    }
}
/*
    function mintSign() external payable callerIsUser{
        require(!hasMintedSign[msg.sender], "You have already minted Sign NFT");
        require(msg.value >= SignsPrice, "Insufficient funds");
        
        
        _mint(msg.sender, SignsCollection, MintedSignNFTId, "");
        NuminousToken.transferFrom(address(this), msg.sender, 100);        
        hasMintedSign[msg.sender] = true;
    }

    function mintTarot() external payable callerIsUser{
        require(hasSign[msg.sender], "You must own at least one Sign NFT to mint a Tarot");
        require(mintedSigns[msg.sender] > 0, "You must own at least one Tarot to mint a Sign");
        require(msg.value >= TarotsPrice, "Insufficient funds");


        mintedTarots[msg.sender]++;

        
        _mint(msg.sender, TarotsCollection, mintedTarots[msg.sender], "");
    }

    function mintSign(uint256 quantity) external payable callerIsUser{
        require(msg.value >= SignsPrice, "Insufficient funds");
        require(totalSupply() + quantity <= collectionSize, "reached max supply");

        mintedSigns[msg.sender]++;


        _mint(msg.sender, SignsCollection, mintedSigns[msg.sender], "");
    }
*/
