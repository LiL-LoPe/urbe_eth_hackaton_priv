// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract NecessitiesToken is ERC20 {
    address public contractOwner;
    uint256 public maxSupply;

    constructor() ERC20("NecessitiesToken", "NCSSTKN") {
        maxSupply = 4200 * 10 ** uint256(decimals());
        contractOwner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == contractOwner, "Only contract owner can call this function");
        _;
    }

    function mint(address account, uint256 amount) public onlyOwner {
        require(totalSupply() + amount <= maxSupply, "Exceeds maximum supply");
        _mint(account, amount);
    }

    function transferOwnership(address newOwner) public onlyOwner {
        contractOwner = newOwner;
    }
}
