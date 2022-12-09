// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;


import "@openzeppelin/contracts/access/Ownable.sol";

interface Token {
    function transfer(address recipient, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (uint256);    
}

contract Stake is Ownable {
    
    Token mtkToken;

    uint multiplyer = 10;

    mapping(uint => address) public idToHolder;
    mapping (address => uint) holdersAmount;

    // constructor(Token _tokenAddress) {          
    //     mtkToken = _tokenAddress;        
    // } 

    function SetToken(Token _tokenAddress) public onlyOwner{
        mtkToken = _tokenAddress;  
    }

    function stakeTokens(uint amount) external payable{
        uint id = mtkToken.transferFrom(msg.sender, address(this), amount) - 1;
        idToHolder[id] = msg.sender;
        holdersAmount[msg.sender] = amount;
    }   

    function unStakeTokens() external returns(bool){
        
        uint amount = holdersAmount[msg.sender];
        amount -= amount * multiplyer / 100;
        mtkToken.transfer(msg.sender, amount);
        holdersAmount[msg.sender] = 0;
        return true;
    }

    function StakedView() external view returns(uint){
        return mtkToken.balanceOf(address(this));
    } 


}