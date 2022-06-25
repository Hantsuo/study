//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract Token {
    string public name = "solidity";
    string public symbol = "SOL";
    uint256 public decimal = 18;
    uint256 public totalSupply = 210000000;
    address public minter;  // 铸造地址
    mapping(address => uint) public balance; //地址余额映射
    
    constructor(address _minter) public {
        minter = _minter;
    }
    

    modifier onlyOwner() {
        require (msg.sender == minter,"not is own account" );
        _;
    }
    function send(address get, uint amount) public{
        require(msg.sender.balance >= amount,"not enougt balance");
        balance[msg.sender] -= amount;
        balance[get] += amount;
        
    }
    function mint(address receiver, uint amount) public onlyOwner{
        balance[receiver] += amount;
    }
   
}


// contract ValueTypes{
//     bool public a = true; //布尔值
//     uint public b = 123; //无符号整数 uint = uint256 0 to 2**256 - 1 
//                          //                 uint8   0 to 2**8 - 1
//                          //                 uint16  0 to 2*16 - 1
//     int public c = -123;
//     address public addr = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
// }

contract Fun {
    function add(uint x,uint y) external pure returns (uint) {
        return x + y;
    }
}
