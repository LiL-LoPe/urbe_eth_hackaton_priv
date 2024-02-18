// Script to deploy two contracts: NuminousNecessities, NecessitiesToken and NuminousNFT

//const { ethers } = require("hardhat");
//
//async function main() {
//  // Deploy NuminousNecessities contract
//  const NuminousNecessities = await ethers.getContractFactory("NuminousNecessities");
//  console.log("Deploying NuminousNecessities...");
//  const numinousNecessities = await NuminousNecessities.deploy();
//  await numinousNecessities.deployed();
//  console.log("NuminousNecessities deployed to:", numinousNecessities.address);
//}
//
//main()
//  .then(() => process.exit(0))
//  .catch((error) => {
//    console.error(error);
//    process.exit(1);
//  });

import { HardhatRuntimeEnvironment } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";
import { Contract } from "ethers";

const deployContracts: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deploy } = hre.deployments;
  const { deployer } = await hre.getNamedAccounts();

  // Deploy NuminousNecessities
 //await deploy("NuminousNecessities", {
 //  from: deployer,
 //  log: true,
 //});

  // Deploy NecessitiesToken
  await deploy("NecessitiesToken", {
    from: deployer,
    log: true,
  });

  // Deploy SignsNFT
  await deploy("SignsNFT", {
    from: deployer,
    args: ["wWECWRVQWTBYENURYMJ"],
    log: true,
  });

  // Deploy TarrotsNFT
  await deploy("TarrotsNFT", {
    from: deployer,
    args: ["xECWTBYEHNJRYM",],
    log: true,
  });

};

export default deployContracts;


// /**
//  * Deploys a contract named "NuminousNecessities" using the deployer account and
//  * constructor arguments set to the deployer address
//  *
//  * @param hre HardhatRuntimeEnvironment object.
//  */
// const deployYourContract: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  
//   const { deployer } = await hre.getNamedAccounts();
//   const { deploy } = hre.deployments;

//   await deploy("NuminousNecessities", {
//     from: deployer,
    
//     log: true,
    
//     autoMine: true,
//   });

  
//   const yourContract = await hre.ethers.getContract<Contract>("NuminousNecessities", deployer);
//   //console.log("👋 Initial greeting:", await yourContract.greeting());
// };

// export default deployYourContract;


// deployYourContract.tags = ["NuminousNecessities"];