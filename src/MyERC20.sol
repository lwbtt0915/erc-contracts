// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {ERC20} from  "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {Ownable} from  "openzeppelin-contracts/contracts/access/Ownable.sol";

contract MyERC20 is ERC20, Ownable {

    constructor(string memory _name, 
    string memory _symbol, 
    uint256 _initialSupply) ERC20(_name, _symbol) Ownable(msg.sender) {
        _mint(msg.sender, _initialSupply * 10 ** decimals());
    }

    // 自定义铸造功能：只有合约所有者可以铸造代币
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }


    // 可选：自定义销毁功能
    function burn(uint256 amount) external {
        _burn(msg.sender, amount * 10 ** decimals());
    }



    // 覆盖ERC20的transfer函数 代币转移
    function transfer(address to, uint256 amount) public override returns (bool) {
        address owner = _msgSender();
        _transfer(owner, to, amount);

        emit Transfer(owner, to, amount);
        return true;
    }


    // 授权
    function approve(address spender, uint256 amount) public override returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, amount);
        emit Approval(owner, spender, amount);
        return true;
    }
}