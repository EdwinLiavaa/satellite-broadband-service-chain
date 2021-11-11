//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import './Equipment.sol';

//// EQUIPMENT_P_E ////
/** @title Equipment_P_E
    Sub Contract for Equipment Transaction between Partner and EndUser
*/

contract Equipment_P_E {
    
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
    * @param Sender Partner Cryptocurrency Network Address
    * @param Shipper Transporter Cryptocurrency Network Address
    * @param Receiver EndUser Cryptocurrency Network Address
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
    function pickPE(
        address BatchID,
        address Shipper
    ) public {
        require(
            Shipper == shipper,
            "Only Associated shipper can call this function."
        );
        status = packageStatus(1);

        Equipment(BatchID).sendPE(
            receiver,
            sender
        );
    }

    // Recieved Equipment Batch by Associate EndUser
    // BatchID Equipment BatchID
    // Receiver EndUser Cryptocurrency Network Address
    function recievePE(
        address BatchID,
        address Receiver
    ) public {
        require(
            Receiver == receiver,
            "Only Associated receiver can call this function."
        );
        status = packageStatus(2);

        Equipment(BatchID).recievedPE(
            Receiver
        );
    }

    // Get Equipment Batch Transaction status in between Operator and Partner
    // Transaction status
    function getBatchIDStatus() public view returns(
        uint
    ) {
        return uint(status);
    }

}
    
