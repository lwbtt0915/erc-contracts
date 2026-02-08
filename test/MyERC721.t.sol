// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {MyERC721} from "../src/MyERC721.sol";

contract ERC721Test is Test {
    MyERC721 nft;

    function setUp() public {
        nft = new MyERC721("MyNFT", "MNFT");
    }

    function testMint() public {
        uint256 tokenId = nft.mint(address(this));
        assertEq(nft.ownerOf(tokenId), address(this));
    }
}
