import { HardhatRuntimeEnvironment } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";
import { Contract } from "ethers";

const deployYourContract: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
    const { deployer } = await hre.getNamedAccounts();
    const { deploy } = hre.deployments; await deploy("NuminousNecessities", {
        from: deployer,
        log: true,
        autoMine: true,
    });
};
export default deployYourContract;
deployYourContract.tags = ["NuminousNecessities"];
