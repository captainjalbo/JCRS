// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LogisticsContract {
    address public sender;
    address public courier;
    address public receiver;
    uint public contractValue;
    string public fleetBaseOrderId;
    string public currentStatus;

    modifier onlySender() {
        require(msg.sender == sender, "Not authorized: Only sender can call this");
        _;
    }

    constructor(
        address _courier, 
        address _receiver, 
        uint _contractValue, 
        string memory _fleetBaseOrderId
    ) {
        sender = msg.sender;
        courier = _courier;
        receiver = _receiver;
        contractValue = _contractValue;
        fleetBaseOrderId = _fleetBaseOrderId;
    }

    function updateStatusFromFleetBase(string memory newStatus) public onlySender {
        // Update the status received from FleetBase
        currentStatus = newStatus;
        // Additional logic based on the status, such as triggering attestations
    }
}
