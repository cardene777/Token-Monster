import { HardhatRuntimeEnvironment } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";
import { Contract } from "ethers";

const deployTokenMonsterContract: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployer } = await hre.getNamedAccounts();
  const { deploy } = hre.deployments;

  await deploy("TokenMonster", {
    from: deployer,
    args: [
      "https://res.cloudinary.com/dplp5wtzk/image/upload/v1715440385/token-monster/monster_",
      9,
      2426615],
    log: true,
    autoMine: true,
  });

  const tokenMonsterContract = await hre.ethers.getContract<Contract>("TokenMonster", deployer);
  console.log("👋 Deploy TokenMonster Contract:", await tokenMonsterContract.getAddress());
};

export default deployTokenMonsterContract;

deployTokenMonsterContract.tags = ["TokenMonster"];
