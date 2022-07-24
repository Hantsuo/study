//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TokenAxs is Ownable, ERC20("AXS Network","AXS"){
    uint256 _maxSupply = 100000000 * 10 * 18;
    function mint(address to,uint256 amount) public onlyOwner{
        require (totalSupply() + amount <= _maxSupply,"Over maxSupply");
        _mint(to,amount);
    }
    function maxSupply() public view returns(uint256){
        return _maxSupply;
    }
}