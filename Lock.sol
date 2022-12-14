// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Lock is ERC20, Ownable {
    constructor() ERC20("MyToken", "MTK") {
        _mint(msg.sender, 100000 * 10 ** decimals());
    }

    function approveContract(address spender, uint amount) public returns(bool){
        return approve(spender, amount);
    }
    
}