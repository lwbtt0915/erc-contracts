// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/MyERC20.sol";
import "../src/MyERC721.sol";

contract Deploy is Script {
    function run() external {
        vm.startBroadcast();

        MyERC20 erc20 = new MyERC20("MyToken", "MTK",1000);
        MyERC721 erc721 = new MyERC721("MyNFT", "MNFT");

        vm.stopBroadcast();
    }
}
