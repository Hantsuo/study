//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Tokensell{
    uint public deadline;
    address public axsToken = 0x0aa7726bc0cB085A3C4fbE3B09b91DD7E27f7fea;

    receive() external payable{}
    constructor(uint _time){
        deadline = block.timestamp + _time ;
    }
    function receiveUsdt()public payable{
        require(block.timestamp < deadline);
        require(msg.value > 0);
        IERC20(axsToken).transfer(msg.sender, msg.value * 100);
    }
    function transferUsdt(address to, uint256 amount)public{
        require(block.timestamp < deadline);
        require(msg.sender == axsToken);
        payable(to).transfer(amount);
    }
}