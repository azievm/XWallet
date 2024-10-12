//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract XWallet {

    address owner;
    mapping(address => bool) public walletUsers;
    uint public totalBalance;

    constructor(address[] memory _walletUsers) {
        owner = msg.sender;

        for (uint i = 0; i < _walletUsers.length; i++) {
            walletUsers[_walletUsers[i]] = true;
        }
    }

    function pay() external payable { 
        totalBalance += msg.value;
    }

    function withdraw(uint amount) public {
        if (walletUsers[msg.sender] == true || msg.sender == owner) {
            if (amount < totalBalance){
                payable(msg.sender).transfer(amount);
                totalBalance -= amount;
            }
        }
    }
}