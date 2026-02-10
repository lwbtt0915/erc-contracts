// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/SimpleStaking.sol";
import "../src/MockERC20.sol";
import {console} from "forge-std/console.sol";

contract SimpleStakingTest is Test {
    MockERC20 token;
    SimpleStaking staking;
    address user = address(1);

    function setUp() public {
        token = new MockERC20();
        staking = new SimpleStaking(token, 1e16); // 每秒 0.01 token

        token.transfer(user, 100 ether);
    }

    function testStakeAndClaim() public {
        vm.startPrank(user);
        token.approve(address(staking), 100 ether);

        staking.stake(10 ether);

        vm.warp(block.timestamp + 100); // 快进 100 秒

        staking.claim();
        vm.stopPrank();

        uint256 balance = token.balanceOf(user);
        console.log("User balance after claiming reward: %s", balance);
        assertGt(balance, 90 ether); // 获得奖励
    }
}
