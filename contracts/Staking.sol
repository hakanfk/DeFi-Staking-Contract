// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract Staking {
    IERC20 public immutable stakingToken;
    IERC20 public immutable rewardToken;

    address public owner;

    constructor(address _stakingToken, address _rewardToken) {
        stakingToken = IERC20(_stakingToken);
        rewardToken = IERC20(_rewardToken);
        owner = msg.sender;
    }

    error InvalidAmount(uint sent, uint minRequired);
    error SentFailed();

    mapping(address => uint) public stakedByUser;
    mapping(address => uint) public usersReward;
    mapping(address => uint) public stakedDurationofUser;

    uint public totalStaked;
    uint public constant rewardPerToken = 1;

    modifier updateReward(address _caller) {
        uint userReward = calculateReward(_caller);
        usersReward[_caller] += userReward;
        stakedDurationofUser[_caller] = block.timestamp;
        _;
    }

    function calculateReward(address _caller) internal view returns (uint) {
        uint duration = block.timestamp - stakedDurationofUser[_caller];
        uint reward = duration * rewardPerToken * stakedByUser[_caller];
        return reward;
    }

    function deposit(uint _amount) external updateReward(msg.sender) {
        if (_amount <= 0) {
            revert InvalidAmount(_amount, 1);
        } else {
            bool success = stakingToken.transferFrom(
                msg.sender,
                address(this),
                _amount
            );
            if (success) {
                stakedByUser[msg.sender] = _amount;
                stakedDurationofUser[msg.sender] = block.timestamp;
                totalStaked += _amount;
            } else {
                revert SentFailed();
            }
        }
    }

    function withdrawReward() external updateReward(msg.sender) {
        if (usersReward[msg.sender] <= 0) {
            revert InvalidAmount(usersReward[msg.sender], 1);
        } else {
            uint reward = usersReward[msg.sender];
            usersReward[msg.sender] = 0;
            bool success = stakingToken.transfer(msg.sender, reward);
            if (!success) revert SentFailed();
        }
    }

    function withdrawFunds(uint _amount) external updateReward(msg.sender) {
        if (_amount <= 0) revert InvalidAmount(_amount, 1);
        if (stakedByUser[msg.sender] <= 0)
            revert InvalidAmount(stakedByUser[msg.sender], 1);

        stakedByUser[msg.sender] -= _amount;
        totalStaked -= _amount;
        stakingToken.transfer(msg.sender, _amount);
    }
}

interface IERC20 {
    function totalSupply() external view returns (uint);

    function balanceOf(address account) external view returns (uint);

    function transfer(address recipient, uint amount) external returns (bool);

    function allowance(
        address owner,
        address spender
    ) external view returns (uint);

    function approve(address spender, uint amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);
}
