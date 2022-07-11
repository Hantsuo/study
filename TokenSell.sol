//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./TokenUsdt.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Tokensell{
        uint256 public price = 1 * 10 * 18;
        uint256 userbalance = 0;
        uint starttime;
        uint endtime;
        address public axsToken = 0x0aa7726bc0cB085A3C4fbE3B09b91DD7E27f7fea;
        mapping(address => uint) public _balance;

    function launch(uint _starttime , uint _endtime)external view{
        require(_starttime >= block.timestamp);
        require(_endtime >= _starttime);
        require(_endtime <= block.timestamp + 30 days);
        
    }
    function sale(address get,uint256 buynmu)public{
        require(block.timestamp >= starttime);
        require(block.timestamp <= endtime);
        uint256 paynum = buynmu * price / 10 ** 18;
        IERC20(axsToken).transferFrom(msg.sender , address(this),paynum);
        _balance[get] += buynmu;
    }
    function wuthdraw()public{
        require(block.timestamp >= starttime);
        require(block.timestamp <= endtime);
        uint bal = IERC20(axsToken).balanceOf(address(this));
        IERC20(axsToken).transfer(0xdDE601eBe61EC5fD0729125D4Fd89F0f3b32B296,bal);
    }
    
}