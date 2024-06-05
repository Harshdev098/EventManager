// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 < 0.9.0;
contract eventManager{
    struct Event{
        address organizer;
        string eventName;
        uint eventDate;
        uint ticketPrice;
        uint ticketCount;
        uint ticketRem;
    }
    mapping (uint => Event) public events;
    mapping (address =>mapping (uint =>uint)) public tickets;
    uint public key;
    function CreateEvent(string memory name, uint date, uint price, uint count) public {
        require(count>0,"you have to give ticket count more than 0");
        require(date>block.timestamp);
        events[key]=Event(msg.sender,name,date,price,count,count);
        events[key].organizer=msg.sender;
        key++;
    } 
    function buyTicket(uint id,uint quantity) payable public {
        require(msg.sender!=events[id].organizer,"you are an organizer");
        require(events[id].eventDate>block.timestamp,"event has already happened");
        require(events[id].eventDate!=0,"event does not exist");
        Event storage _event=events[id];
        require(msg.value==_event.ticketPrice*quantity,"ether is not sufficient");
        require(_event.ticketRem>=quantity,"not enough tickets");
        _event.ticketRem-=quantity;
        tickets[msg.sender][id]+=quantity;
    }
    function getbalance() public view{
        address(this).balance;
    }
}