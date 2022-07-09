// SPDX-License-Identifier: MIT
pragma experimental ABIEncoderV2;
pragma solidity 0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Token is Ownable, ERC20("My Token", "USDT") {

    uint256 public _maxSupply = 100000000 * 10 ** 8;
    uint256 public _maxSupply33333 = 100000000 * 10 ** 8;
    
    function mint(address to, uint256 amount) public onlyOwner {
        require(totalSupply() + amount <= _maxSupply, "Over maxSupply");
        _mint(to, amount);
    } 

    function decimals() public view virtual override returns (uint8) {
        return 8;
    }

    function maxSupply() public view returns (uint256) {
        return _maxSupply;
    }

    function setMaxSupply(uint256 sMaxSupply) public {
        _maxSupply = sMaxSupply;
    }

    function getUint8() public view returns (int) {
        return 2 ** 8;
    }

    function getUint16() public view returns (int) {
        return 2 ** 16;
    }
}