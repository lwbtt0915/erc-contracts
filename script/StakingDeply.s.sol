
// script/TransferERC20.s.sol
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {SimpleStaking} from "../src/SimpleStaking.sol";
import {console} from "forge-std/console.sol";
contract StakingDeply is Script {
    function run() external {
        uint256 deployerKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.addr(deployerKey);
        console.log("deployer:", deployer);
        
        address stakingToken = vm.envAddress("STAKING_TOKEN");
        uint256 rewardRate   = vm.envUint("REWARD_RATE");

        vm.startBroadcast(deployerKey);

        SimpleStaking staking = new SimpleStaking(
            stakingToken,
            rewardRate
        );

        vm.stopBroadcast();

        console.log("Staking deployed at:", address(staking));
    }
}