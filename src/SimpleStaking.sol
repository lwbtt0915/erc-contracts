// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {IERC20} from  "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract SimpleStaking { 

    IERC20 public immutable stakingToken; // 质押代币 immutable 部署后不可更改，省 gas，防止被换币
    IERC20 public immutable rewardToken;  // 奖励代币
    uint256 public rewardRate;           // 每区块奖励率(每秒奖励，单位：token)

    struct StakeInfo {
        uint256 amount;                  // 质押数量
        uint256 rewardDebt;              // 已经领取的奖励
        uint256 lastUpdate               // 上次更新奖励的时间
    }

    mapping(address => StakeInfo) public users;

    constructor(IERC20 _stakingToken, uint256 _rewardRate) {
        stakingToken = _stakingToken;
        rewardRate = _rewardRate;
    }
   


   // 核心逻辑 质押
   // 先结算旧奖励
   // 再增加质押数量   
   // 最后转账
   function stake(uint256 amount) external {
      require(amount > 0, "amount must be greater than 0");

      _updateReward(msg.sender);
      users[msg.sender].amount += amount;
      users[msg.sender].startTime = block.timestamp;

      stakingToken.transferFrom(msg.sender, address(this), amount);
   }



//    提币取回本金
   function withdraw(uint256 amount) external { 
      UserInfo storage user = users[msg.sender];
      require(user.amount >= amount, "withdraw: not enough");

      _updateReward(msg.sender);

      user.amount -= amount;
      stakingToken.transfer(msg.sender, amount);
   }


//    领取奖励
   function claimReward() external {
      _updateReward(msg.sender);

      UserInfo storage user = users[msg.sender];
      require(user.rewardDebt > 0, "no reward");

      users[msg.sender].rewardDebt = 0;
      stakingToken.transfer(msg.sender, user.rewardDebt);
   }



   function pendingReward(address userAddr) internal view returns (uint256 pending) {
      UserInfo memory user = users[userAddr];
      if (user.amount == 0) return user.rewardDebt;

     uint256 timePassed = block.timestamp - user.lastUpdate;
     uint256 reward = user.amount * rewardRate * timePassed / 1e18;

      return reward+user.rewardDebt;
   }



    //1️⃣ 计算上次结算 → 现在经过了多久
    // 2️⃣ 按公式算出奖励
   // 3️⃣ 把奖励累加到 rewardDebt
   function _updateReward(address userAddr) internal {
      UserInfo storage user = users[userAddr];
      

      if(user.amount > 0) {
        uint256 timePassed = block.timestamp - user.lastUpdate;
        
        uint256 reward = user.amount * rewardRate * timePassed / 1e18;
        user.rewardDebt += reward;
      }

      user.lastUpdate = block.timestamp;
   }





}
