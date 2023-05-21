const { ethers } = require("hardhat");

async function main() {
  const contractFactory = await ethers.getContractFactory("Staking");
  console.log("Deploying the contract...");

  const contract = await contractFactory.deploy();

  console.log("Deployed. Success!");

  await contract.deployed();

  console.log(contract);
}

main()
  .then()
  .catch((err) => console.log(err));
