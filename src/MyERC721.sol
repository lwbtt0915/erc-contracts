// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;


import {ERC721} from  "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import {Ownable} from  "openzeppelin-contracts/contracts/access/Ownable.sol";


contract MyERC721 is ERC721, Ownable {

    uint256 private _nextTokenId;

    constructor(
        string memory name_,
        string memory symbol_
    ) ERC721(name_, symbol_) Ownable(msg.sender) {}



     function mint(address to) external onlyOwner returns(uint256) {
        _mint(to, _nextTokenId);
        _nextTokenId++;
        return _nextTokenId;
    }



    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public override {
        _transfer(from, to, tokenId);
    }


    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes memory _data
    ) public override {
        _safeTransfer(from, to, tokenId, _data);
    }


    function approve(address to, uint256 tokenId) public override {
        super.approve(to, tokenId);
    }
    function setApprovalForAll(address operator, bool approved) public override {
        super.setApprovalForAll(operator, approved);
    }
    function getApproved(uint256 tokenId) public view override returns (address) {
        return super.getApproved(tokenId);
    }


    function ownerOf(uint256 tokenId) public view override returns (address) {
        return super.ownerOf(tokenId);
    }

    function balanceOf(address owner) public view override returns (uint256) {
        return super.balanceOf(owner);
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        return tokenURI(tokenId);
    }

}
