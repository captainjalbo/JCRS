// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IEAS {
    function getAttestation(address issuer, address subject, bytes32 schema) external view returns (bool);
}

contract LogisticsContract {
    address public sender;
    address public courier;
    address public receiver;
    uint public contractValue;
    bool public packageApproved = false;
    IEAS public eas;
    bytes32 public schemaId;

    enum ContractState { Created, TrustSetup, KeyShared, DepositMade, PackageSent, Approved, Shipping, Completed, Cancelled }
    ContractState public state;

    modifier onlySender() {
        require(msg.sender == sender, "Not authorized: Only sender can call this");
        _;
    }

    modifier onlyCourier() {
        require(msg.sender == courier, "Not authorized: Only courier can call this");
        _;
    }

    constructor(
        address _courier, 
        address _receiver, 
        uint _contractValue, 
        address _easAddress,
        bytes32 _schemaId
    ) {
        sender = msg.sender;
        courier = _courier;
        receiver = _receiver;
        contractValue = _contractValue;
        eas = IEAS(_easAddress);
        schemaId = _schemaId;
        state = ContractState.Created;
    }

    function TrustSetup() public onlySender {
        require(state == ContractState.Created, "Invalid state");
        state = ContractState.TrustSetup;
    }

    function ShareKey() public onlySender {
        require(state == ContractState.TrustSetup, "Invalid state");
        state = ContractState.KeyShared;
    }

    function DepositMoney() public payable onlySender {
        require(state == ContractState.KeyShared, "Invalid state");
        require(msg.value == contractValue, "Incorrect deposit amount");
        state = ContractState.DepositMade;
    }

    function PackageSent() public onlyCourier {
        require(state == ContractState.DepositMade, "Invalid state");
        state = ContractState.PackageSent;
    }

    function PackageApproved() public onlyCourier {
        require(state == ContractState.PackageSent, "Invalid state");
        require(
            eas.getAttestation(courier, address(this), schemaId),
            "EAS attestation required for package approval"
        );
        packageApproved = true;
        state = ContractState.Approved;
    }

    function IparcelShipping() public onlyCourier {
        require(packageApproved, "Package not approved");
        require(state == ContractState.Approved, "Invalid state");
        require(
            eas.getAttestation(courier, address(this), schemaId),
            "EAS attestation required for iParcel shipping"
        );
        state = ContractState.Shipping;
    }

    function completeTransaction() public onlySender {
        require(state == ContractState.Shipping, "Package not in shipping state");
        state = ContractState.Completed;
        payable(courier).transfer(address(this).balance);
    }

    function cancelContract() public onlySender {
        require(state != ContractState.Completed, "Cannot cancel a completed contract");
        state = ContractState.Cancelled;
        payable(sender).transfer(address(this).balance);
    }
}
