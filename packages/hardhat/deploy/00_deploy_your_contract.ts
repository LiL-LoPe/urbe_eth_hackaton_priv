// Script to deploy two contracts: NuminousNecessities, NecessitiesToken and NuminousNFT

const { ethers } = require("hardhat");

async function main() {
  // Deploy NuminousNecessities contract
  const NuminousNecessities = await ethers.getContractFactory("NuminousNecessities");
  console.log("Deploying NuminousNecessities...");
  const numinousNecessities = await NuminousNecessities.deploy();
  await numinousNecessities.deployed();
  console.log("NuminousNecessities deployed to:", numinousNecessities.address);

  // // Deploy NecessitiesToken contract
  // const NecessitiesToken = await ethers.getContractFactory("NecessitiesToken");
  // console.log("Deploying NecessitiesToken...");
  // const necessitiesToken = await NecessitiesToken.deploy();
  // await necessitiesToken.deployed();
  // console.log("NecessitiesToken deployed to:", necessitiesToken.address);

  // // Deploy NuminousNFT contract
  // const NuminousNFT = await ethers.getContractFactory("NuminousNFT");
  // console.log("Deploying NuminousNFT...");
  // const NuminousNFT = await NuminousNFT.deploy();
  // await NuminousNFT.deployed();
  // console.log("NuminousNFT deployed to:", NuminousNFT.address);

}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
