
// script/TransferERC20.s.sol
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TransferERC20 is Script {
    function run() external {
        address token = 0x7f52576Bf43A55F533972A238daa2E794cB9b87A;
        address to = 0x00267645F5677350F740da9C8586Ded87816D811;
        uint256 amount = 1e18;

        vm.startBroadcast();
        bool success = IERC20(token).transfer(to, amount);
        require(success, "Transfer failed");
        vm.stopBroadcast();
    }
}
