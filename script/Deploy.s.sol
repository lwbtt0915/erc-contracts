// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {MyERC20} from "../src/MyERC20.sol";
import {MyERC721} from "../src/MyERC721.sol";
import {console} from "forge-std/console.sol";


contract Deploy is Script {
    function run() external {
        vm.startBroadcast();

        MyERC20 erc20 = new MyERC20("MyToken", "MTK",1000);
        erc20.mint(msg.sender, 1000);
        console.log("MyERC20 deployed to: %s", address(erc20));
        MyERC721 erc721 = new MyERC721("MyNFT", "MNFT");
        console.log("MyERC721 deployed to: %s", address(erc721));
        erc721.mint(msg.sender);

        vm.stopBroadcast();
    }
}
