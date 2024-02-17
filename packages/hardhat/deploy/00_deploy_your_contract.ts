// Script to deploy two contracts: NuminousNecessities and NecessitiesToken

const { ethers } = require("hardhat");

async function main() {
  // Deploy NuminousNecessities contract
  const NuminousNecessities = await ethers.getContractFactory("NuminousNecessities");
  console.log("Deploying NuminousNecessities...");
  const numinousNecessities = await NuminousNecessities.deploy();
  await numinousNecessities.deployed();
  console.log("NuminousNecessities deployed to:", numinousNecessities.address);

  // Deploy NecessitiesToken contract
  const NecessitiesToken = await ethers.getContractFactory("NecessitiesToken");
  console.log("Deploying NecessitiesToken...");
  const necessitiesToken = await NecessitiesToken.deploy();
  await necessitiesToken.deployed();
  console.log("NecessitiesToken deployed to:", necessitiesToken.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
