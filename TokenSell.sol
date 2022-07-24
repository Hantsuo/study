//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./TokenUsdt.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract presale{
        uint256 public price;
        uint256 public starttime;
        uint256 public endtime;
        uint256 public userWithdrawTime;
        address public axsToken = 0xBcdA1F3B99609780a5dc57699269B0089807c817;
        address public Usdt = 0x9ae5bfE06e70Dd5879320118Fbc194855f6C298D;
        mapping(address => uint256) public _balances;
        mapping(address => uint256) public userBuyTotalUsdt;
        mapping(address => address) public parents;
        uint public maxAmount = 100 * 10 ** 18;
        uint inviteNum;
        uint inviteLv1 = 5 * 10 * 17;
        uint inviteLv2 = 3 * 10 * 17;
        uint inviteLv3 = 2 * 10 * 17;
        uint inviteLv4 = 1 * 10 * 17;
        uint inviteLv5 = 5 * 10 * 16;



    
    

    struct presaleInfo {
        uint starttime;
        uint endtime;
        uint price;

    }

    PresaleInfo[] presaleInfos;
    
    constructor (uint256 _userWithdrawTime)public{
        userWithdrawTime = _userWithdrawTime;
    }

    function setUserWithdrawTime() public onlyOwner {
        userWithdrawTime = _userWithdrawTime;
    }

    function createPreSale(PresaleInfo memory persaleInfo) public onlyOwner {
        persaleInfos.push(presaleInfo);

    }
    function addInvite (address parentAddress) public {
        require(parentAddress != msg.sender);
        parents[parentAddress] = parentAddress;
        for (i = 0;i < parentAddress.lengh; i++){
            if (parentAddress[i] == msg.sender){
                inviteNum++;
            }
        }
    }
    function sale(uint256 pid) public {
        PreSaleInfo memory preSaleInfo = preSaleInfos[pid];
        require(block.timestamp >= preSaleInfo.starttime);
        require(block.timestamp <= preSaleInfo.endtime);
        require(userBuyTotalUsdt[msg.sender] <= preSaleInfos.lengh * maxAmount);
        uint256 getTokenNum = maxAmount / preSaleInfo.price;
        IERC20(Usdt).transferFrom(msg.sender, address(this), maxAmount);
        _balances[msg.sender] += getTokenNum;
        userBuyTotalUsdt[msg.sender] += maxAmount;
        if (inviteNum == 9){
            _balances[msg.sender] += getTokenNum * inviteLv1;
        }else if(inviteNum == 8){
            _balances[msg.sender] += getTokenNum * inviteLv2;
        }else if(inviteNum == 7){
            _balances[msg.sender] += getTokenNum * inviteLv3;
        }else if(inviteNum == 5){
            _balances[msg.sender] += getTokenNum * inviteLv4;
        }else if(inviteNum <= 4 || inviteNum > 1)  {
            _balances[msg.sender] += getTokenNum * inviteLv4;
        }
    }
    function Userwithdraw() public {
        require(block.timestamp > userWithdrawTime);
        uint bal = _balances[msg.sender];
        _balances[msg.sender] = 0;
        IERC20(axsToken).transfer(msg.sender,bal);
    }
    function teamWithdraw()public onlyOwner{
        require(block.timestamp > userWithdrawTime);
        uint bal = IERC20(Usdt).balanceOf(address(this));
        IERC20(Usdt).transfer(msg.sender,bal);
    }
    
}