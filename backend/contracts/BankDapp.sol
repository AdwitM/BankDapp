// SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.15;

contract BankDapp {
    address public bankOwner;
    string public bankName;
    mapping(address => uint256) public customerBalance;

    constructor() {
        bankOwner = msg.sender;
    }

    function depositMoney() external payable {
        require(msg.value != 0, "You need to deposit some amount of money!");
        customerBalance[msg.sender] += msg.value;
    }

    function changeBankName(string memory _name) external {
        require(
            msg.sender == bankOwner,
            "You must be the owner to set the name of the bank"
        );
        bankName = _name;
    }

    function withdrawMoney(uint256 _amount) external payable {
        require(
            _amount <= customerBalance[msg.sender],
            "insufficeint balance in bank account"
        );
        customerBalance[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
    }

    function checkCustomerBalance() external view returns (uint256) {
        return customerBalance[msg.sender];
    }

    function totalBankBalance() external view returns (uint256) {
        require(
            msg.sender == bankOwner,
            "You must be the owner of the bank to see all balances."
        );
        return address(this).balance;
    }
}
