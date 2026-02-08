// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;


import {Test} from "forge-std/Test.sol";
import {MyERC20} from "../src/MyERC20.sol";
contract MyERC20Test is Test {
    MyERC20 public myToken;


    function setUp() public {
        myToken = new MyERC20("MyToken", "MTK", 1000);
        myToken.mint(address(this), 1000 ether);
    }

    function testTransfer() public {
        bool success = myToken.transfer(address(1), 100 ether);
        assertTrue(success);
        assertEq(myToken.balanceOf(address(1)), 100 ether);
    }
}