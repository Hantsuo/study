//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract Token {
    string public name = "Solidity";
    string public symbol = "SOL";
    uint256 public decimal = 18;
    uint256 public _maxSupply = 21000000 *10 ** 18;
    address public minter;  // 铸造地址
    mapping(address => uint) public _balance; //地址余额映射
    uint public _totalSupply;
    constructor(address _minter) {
        minter = _minter;
    }
    

    modifier onlyOwner() {
        require (msg.sender == minter,"not is own account" );
        _;
    }

    function send(address get, uint amount) public{
        require(_balance[msg.sender] >= amount,"not enougt balance");
        _balance[msg.sender] -= amount;
        _balance[get] += amount;
        
    }
    function mint(address receiver, uint amount) public onlyOwner{
        require(_totalSupply + amount <= _maxSupply,"over maxsupply");
        _totalSupply += amount;
        _balance[receiver] += amount;
    }
   
}   
