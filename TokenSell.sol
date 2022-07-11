//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./TokenUsdt.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Tokensell{
        uint256 public price = 1 * 10 * 18;
        uint starttime;
        uint endtime;
        address public axsToken = 0xBcdA1F3B99609780a5dc57699269B0089807c817;
        address public Usdt = 0x9ae5bfE06e70Dd5879320118Fbc194855f6C298D;
        mapping(address => uint) public _balance;
    
    function getuserbalance(address userbalance)public view returns(uint256){
        uint256 bal = IERC20(0x9ae5bfE06e70Dd5879320118Fbc194855f6C298D).balanceOf(userbalance);
        return bal;
    }
    function launch(uint _starttime , uint _endtime)public view{
        require(_starttime >= block.timestamp);
        require(_endtime >= _starttime);
        require(_endtime <= block.timestamp + 30 days);
        
    }
    function sale(uint256 buynmu)public{
        require(block.timestamp >= starttime);
        require(block.timestamp <= endtime);
        uint256 paynum = buynmu * price / 10 ** 18;
        IERC20(Usdt).transferFrom(msg.sender, address(this),paynum);
        _balance[msg.sender] += buynmu;
    }
    function withdraw()public{
        require(block.timestamp >= starttime);
        require(block.timestamp <= endtime);
        uint bal = IERC20(Usdt).balanceOf(address(this));
        IERC20(Usdt).transfer(0xdDE601eBe61EC5fD0729125D4Fd89F0f3b32B296,bal);
    }
    function Userwithdraw()public{
        require(block.timestamp >= starttime);
        require(block.timestamp <= endtime);
        uint bal = IERC20(axsToken).balanceOf(address(this));
        IERC20(axsToken).transfer(msg.sender,bal);
    }
    
}