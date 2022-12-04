// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;


contract BuyMeACoffee{

    event NewMemo(
        address from,
        uint256 timestamp,
        string name,
        string message
    );

    struct Memo{
        address from;
        uint256 timestamp;
        string name;
        string message;
    }

// list of all memos received
    Memo[] memos;

// address of contract deployer

    address payable owner;

//  deploy logic

    constructor(){
        owner = payable(msg.sender);
    }

    function buycoffee(string memory _name , string memory _message) public payable{
        require(msg.value>0,"cant buy with 0 ether");

//  add memo to storage
    memos.push(Memo(
        msg.sender,
        block.timestamp,
        _name,
        _message
    ));

    emit NewMemo(
        msg.sender,
        block.timestamp,
        _name,
        _message
    );
    }

    function withdrawTips() public{

        require(owner.send(address(this).balance));

    }

    function getMemos() public view returns (Memo[] memory){

        return memos;

    }


}