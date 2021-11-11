//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import './Equipment.sol';

//// EQUIPMENT_O_P ////
/** @title Equipment_O_P
    Sub Contract for Equipment Transaction between Operator and Partner
*/

contract Equipment_O_P {
    
    address Owner;

    enum packageStatus { atcreator, picked, delivered }
    
    address batchid;
    address sender;
    address shipper;
    address receiver;

    packageStatus status;

    /** 
    * @notice Create SubContract for Equipment Transaction
    * @param BatchID Equipment BatchID
    * @param Sender Operator Cryptocurrency Network Address
    * @param Shipper Transporter Cryptocurrency Network Address
    * @param Receiver Partner Cryptocurrency Network Address
    */

    constructor(
        address BatchID,
        address Sender,
        address Shipper,
        address Receiver
    ) public {
        Owner = Sender;
        batchid = BatchID;
        sender = Sender;
        shipper = Shipper;
        receiver = Receiver;
        status = packageStatus(0);

    }

    // Pick Equipment Batch by Associated Transporter
    // BatchID Equipment BatchID
    // Shipper Transporter Cryptocurrency Network Address
    function pickOP(
        address BatchID,
        address Shipper
    ) public {
        require(
            Shipper == shipper,
            "Only Associated shipper can call this function."
        );
        status = packageStatus(1);

        Equipment(BatchID).sendOP(
            receiver,
            sender
        );
    }
    
    // Recieved Equipment Batch by Associate Partner
    // BatchID Equipment BatchID
    // Receiver Partner Cryptocurrency Network Address
    function recieveOP(
        address BatchID,
        address Receiver
    ) public {
        require(
            Receiver == receiver,
            "Only Associated receiver can call this function."
        );
        status = packageStatus(2);

        Equipment(BatchID).recievedOP(
            Receiver
        );
    }

    // Get Equipment Batch Transaction status in between Operator and Partner
    // Transaction status
    function getBatchIDStatus() public view returns(uint) {
        return uint(status);
    }
}
    
