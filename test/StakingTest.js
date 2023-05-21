const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Staking", function () {
  let Staking,
    staking,
    RewardToken,
    rewardToken,
    StakingToken,
    stakingToken,
    owner,
    addr1;

  beforeEach(async () => {
    StakingToken = await ethers.getContractFactory("ERC20Mock");
    stakingToken = await StakingToken.deploy("StakingToken", "STK");

    RewardToken = await ethers.getContractFactory("ERC20Mock");
    rewardToken = await RewardToken.deploy("RewardToken", "RWD");

    Staking = await ethers.getContractFactory("Staking");
    staking = await Staking.deploy(stakingToken.address, rewardToken.address);

    [owner, addr1] = await ethers.getSigners();
  });

  describe("deposit", function () {
    it("Should revert if the staking amount is 0", async function () {
      await stakingToken.transfer(
        addr1.address,
        ethers.utils.parseEther("1000")
      );
      await stakingToken
        .connect(addr1)
        .approve(staking.address, ethers.utils.parseEther("1000"));
      await expect(staking.connect(addr1).deposit(0)).to.be.revertedWith(
        "InvalidAmount"
      );
    });
  });

  describe("withdrawReward", function () {
    it("Should revert if the user reward is 0", async function () {
      await expect(staking.connect(addr1).withdrawReward()).to.be.revertedWith(
        "InvalidAmount"
      );
    });
  });

  describe("withdrawFunds", function () {
    it("Should revert if the withdrawal amount is 0", async function () {
      await expect(staking.connect(addr1).withdrawFunds(0)).to.be.revertedWith(
        "InvalidAmount"
      );
    });
  });
});
