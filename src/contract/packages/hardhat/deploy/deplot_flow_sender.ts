import { HardhatRuntimeEnvironment } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";
import { Contract } from "ethers";

const deployFlowSenderContract: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployer } = await hre.getNamedAccounts();
  const { deploy } = hre.deployments;

  await deploy("FlowSender", {
    from: deployer,
    args: [["0x46fd5cfB4c12D87acD3a13e92BAa53240C661D93"]],
    log: true,
    autoMine: true,
  });

  const flowSenderContract = await hre.ethers.getContract<Contract>("FlowSender", deployer);
  console.log("👋 Deploy FlowSender Contract:", await flowSenderContract.getAddress());
};

export default deployFlowSenderContract;

deployFlowSenderContract.tags = ["FlowSender"];
