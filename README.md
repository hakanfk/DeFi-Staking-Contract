# Staking Contract

The Staking Contract is a decentralized application that allows users to stake their tokens and earn rewards over time. This particular contract utilizes two ERC20 tokens, one as a staking token and the other as a reward token.

## Setup

This contract has been developed using Solidity ^0.8.

## Prerequisites

You should have a basic understanding of Ethereum, Solidity, and how to use MetaMask or other web3 providers. You should also have Node.js (v10 or later) installed.

## Key Components

stakingToken: This is the ERC20 token users will stake.

rewardToken: This is the ERC20 token users will earn as rewards.

stakedByUser: This mapping stores the amount staked by each user.

usersReward: This mapping keeps track of the rewards each user has earned over time.

stakedDurationofUser: This mapping stores the timestamp of when each user last interacted with the contract (staked, withdrew, etc.).

rewardPerToken: This constant value denotes the amount of reward tokens earned per staked token per second.

## Functions

calculateReward: A view function that calculates the rewards a user has earned since the last time they interacted with the contract.

deposit: A user calls this function to stake their tokens. This function also calls the updateReward modifier to update the user's reward.

withdrawReward: A user calls this function to withdraw their earned rewards. It also updates the user's reward with the updateReward modifier.

withdrawFunds: A user calls this function to withdraw their staked tokens. It also updates the user's reward with the updateReward modifier.

## Testing

This contract includes a series of tests written in JavaScript using ethers.js with hardhat, waffle, and chai. To run the tests, execute npx hardhat test in your terminal.

## License

This project is licensed under the MIT License.

## Disclaimer

This is a simplified example of a staking contract, for educational purposes only. Real-world staking platforms have much more complex mechanisms to handle risks and rewards. Always do your own research before interacting with any DeFi protocol.
