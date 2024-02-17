// Script to deploy two contracts: NuminousNecessities, NecessitiesToken and NuminousNFT

const { ethers } = require("hardhat");

async function main() {
  // Deploy NuminousNecessities contract
  const NuminousNecessities = await ethers.getContractFactory("NuminousNecessities");
  console.log("Deploying NuminousNecessities...");
  const numinousNecessities = await NuminousNecessities.deploy();
  await numinousNecessities.deployed();
  console.log("NuminousNecessities deployed to:", numinousNecessities.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
