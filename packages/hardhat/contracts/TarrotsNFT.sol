// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "./NecessitiesToken.sol";

contract TarrotsNFT is ERC721Enumerable, Ownable {
    using Strings for uint256;

    string _baseTokenURI;
	address public contractOwner;
	uint256 private max_supply = 4200;
	address master = 0xF56FF109B4441C845A4085CB0135f61F21bd4d65;
    NecessitiesToken public necessitiesToken;

    constructor(
		string memory baseURI
	) ERC721("Tarrots", "TRRTNFT") Ownable(msg.sender) {
		setBaseURI(baseURI);
	}

	function mintTarrots(uint256 num, uint256 price) external payable {
		uint256 supply = totalSupply();
		uint256 mintPriceS = (12 * num) * (10 ** 16);
		require(price == mintPriceS, "Incorrect Ether value sent");
		require(supply + num <= max_supply, "Exceeds maximum Tarrots supply");
		_safeMint(msg.sender, num);
	}

    function _baseURI() internal view virtual override returns (string memory) {
		return _baseTokenURI;
	}

	function setBaseURI(string memory baseURI) public onlyOwner {
		_baseTokenURI = baseURI;
	}

	function withdrawal(uint amount) external onlyOwner {
		require(amount <= address(this).balance, "Insufficient balance");
		payable(owner()).transfer(address(this).balance);
	}

	function setAddressToken(address _addressnecessitiesToken) external {
		necessitiesToken = NecessitiesToken(_addressnecessitiesToken);
	}

    function balanceOfNFT(address account) public view returns (uint256) {
        require(account != address(0), "Invalid address");
        return balanceOf(account);
    }

	function buyShirt(uint256 num) external {
        require(balanceOfNFT(msg.sender) > 0, "You must have at least one TarrotNFT");
        uint256 shirtPrice = 20 * num;
        necessitiesToken.transferFrom(msg.sender, address(this), shirtPrice);
	}
}
