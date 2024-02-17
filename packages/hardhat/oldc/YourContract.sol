//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

// Useful for debugging. Remove when deploying to a live network.
import "hardhat/console.sol";

// Use openzeppelin to inherit battle-tested implementations (ERC20, ERC721, etc)
// import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * A smart contract that allows changing a state variable of the contract and tracking the changes
 * It also allows the owner to withdraw the Ether in the contract
 * @author BuidlGuidl
 */
contract YourContract {
	// State Variables
	address public immutable owner;
	string public greeting = "Building Unstoppable Apps!!!";
	bool public premium = false;
	uint256 public totalCounter = 0;
	mapping(address => uint) public userGreetingCounter;

	// Events: a way to emit log statements from smart contract that can be listened to by external parties
	event GreetingChange(
		address indexed greetingSetter,
		string newGreeting,
		bool premium,
		uint256 value
	);

	// Constructor: Called once on contract deployment
	// Check packages/hardhat/deploy/00_deploy_your_contract.ts
	constructor(address _owner) {
		owner = _owner;
	}

	// Modifier: used to define a set of rules that must be met before or after a function is executed
	// Check the withdraw() function
	modifier isOwner() {
		// msg.sender: predefined variable that represents address of the account that called the current function
		require(msg.sender == owner, "Not the Owner");
		_;
	}

	/**
	 * Function that allows anyone to change the state variable "greeting" of the contract and increase the counters
	 *
	 * @param _newGreeting (string memory) - new greeting to save on the contract
	 */
	function setGreeting(string memory _newGreeting) public payable {
		// Print data to the hardhat chain console. Remove when deploying to a live network.
		console.log(
			"Setting new greeting '%s' from %s",
			_newGreeting,
			msg.sender
		);

		// Change state variables
		greeting = _newGreeting;
		totalCounter += 1;
		userGreetingCounter[msg.sender] += 1;

		// msg.value: built-in global variable that represents the amount of ether sent with the transaction
		if (msg.value > 0) {
			premium = true;
		} else {
			premium = false;
		}

		// emit: keyword used to trigger an event
		emit GreetingChange(msg.sender, _newGreeting, msg.value > 0, 0);
	}

	/**
	 * Function that allows the owner to withdraw all the Ether in the contract
	 * The function can only be called by the owner of the contract as defined by the isOwner modifier
	 */
	function withdraw() public isOwner {
		(bool success, ) = owner.call{ value: address(this).balance }("");
		require(success, "Failed to send Ether");
	}

	/**
	 * Function that allows the contract to receive ETH
	 */
	receive() external payable {}
}

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract NuminousNecessities is Ownable, ERC1155 {
    using Strings for uint256;

    address contract_owner;

    string private _baseTokenURI;

    uint256 public constant TarotsCollection = 1;
    uint256 public constant SignsCollection = 2;
    uint256 public constant NuminousToken = 3;
    uint256 public constant collectionSize = 66;


    uint256 private _status;

    struct TokenOwnership {
        address addr;
        uint64 startTimestamp;
    }

    mapping(address => bool) public hasSign;
    mapping(address => bool) public hasMintedSign;
    mapping(address => uint256) public mintedSigns;
    mapping(address => uint256) public mintedTarots;

    
    uint256 public constant TarotsPrice = 0.01 ether;
    uint256 public constant SignsPrice = 0.005 ether;

    constructor() ERC1155("Sign") {
        
        contract_owner = msg.sender;
        _mint(msg.sender, TarotsCollection, 22, "");
        _mint(msg.sender, SignsCollection, 12, "");
        _mint(msg.sender, NuminousToken, 1200, "");
    }

    modifier callerIsUser() {
        require(tx.origin == msg.sender, "The caller is another contract");
        _;
    }

    //

    //function _baseURI() internal view virtual override returns (string memory) {
    //    return _baseTokenURI;
    //}

    //function setBaseURI(string calldata baseURI) external onlyOwner {
    //    _baseTokenURI = baseURI;
    //}
//
    //function transferOwnership(address newOwner) public virtual onlyOwner {
    //    require(newOwner != address(0), "Ownable: new owner is the zero address");
    //    _setOwner(newOwner);
    //}

//
    

    // function getOwnershipData(uint256 tokenId)
    //     external view
    //     returns (TokenOwnership memory)
    // {
    //     return ownershipOf(tokenId);
    // }

    function mintSign() external payable callerIsUser{
        require(!hasMintedSign[msg.sender], "You have already minted Sign NFT");
        require(msg.value >= SignsPrice, "Insufficient funds");
        //require(totalSupply() + quantity <= collectionSize, "reached max supply");

        mintedSigns[msg.sender]++;


        _mint(msg.sender, SignsCollection, mintedSigns[msg.sender], "");
        hasMintedSign[msg.sender] = true;
    }

    //function mintSign() external payable callerIsUser{
    //    require(!hasMintedSign[msg.sender], "You have already minted Sign NFT");
    //    require(msg.value >= SignsPrice, "Insufficient funds");
    //    
    //    
    //    _mint(msg.sender, SignsCollection, MintedSignNFTId, "");
    //    NuminousToken.transferFrom(address(this), msg.sender, 100);        
    //    hasMintedSign[msg.sender] = true;
    //}

    function mintTarot() external payable callerIsUser{
        require(hasSign[msg.sender], "You must own at least one Sign NFT to mint a Tarot");
        require(mintedSigns[msg.sender] > 0, "You must own at least one Tarot to mint a Sign");
        require(msg.value >= TarotsPrice, "Insufficient funds");


        mintedTarots[msg.sender]++;

        
        _mint(msg.sender, TarotsCollection, mintedTarots[msg.sender], "");
    }
}

