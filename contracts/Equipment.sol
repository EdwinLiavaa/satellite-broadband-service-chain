//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";

/********************************************** Equipment ******************************************/
/// @title Equipment

//Create a new instance of the Equipment package

contract Equipment {

    
    address Owner;

    enum equipmentStatus {
        atsupplier,
        pickedforOperator,
        pickedforPartner,
        deliveredatOperator,
        deliveredatPartner,
        pickedforEndUser,
        deliveredatEndUser
    }

    
    bytes32 description;
    
    bytes32 equipment;
    
    uint quantity;
    
    address shipper;
    
    address supplier;
    
    address operator;
    
    address partner;
    
    address enduser;
    
    equipmentStatus status;

    event ShippmentUpdate(
        address indexed BatchID,
        address indexed Shipper,
        address indexed Receiver,
        uint TransporterType,
        uint Status
    );

    
    //Create new Equipment Batch by Supplier
    // Supp Supplier Cryptocurrency Network Address
    // Des Description of Equipment Batch
    // EM for Equipment
    // Quant Number of units
    // Shpr Transporter Cryptocurrency Network Address
    // Rcvr Receiver Cryptocurrency Network Address
    // RcvrType Receiver Type either Operator(1) or Partner(2)
    constructor(
        address Supp,
        bytes32 Des,
        bytes32 EM,
        uint Quant,
        address Shpr,
        address Rcvr,
        uint RcvrType
    ) public {
        Owner = Supp;
        supplier = Supp;
        description = Des;
        equipment = EM;
        quantity = Quant;
        shipper = Shpr;
        if(RcvrType == 1) {
            operator = Rcvr;
        } else if( RcvrType == 2){
            partner = Rcvr;
        }
    }

    
    //Get Equipment Batch basic Details
    // Equipment Batch Details
    function getEquipmentInfo () public view returns(
        address Supp,
        bytes32 Des,
        bytes32 EM,
        uint Quant,
        address Shpr
    ) {
        return(
            supplier,
            description,
            equipment,
            quantity,
            shipper
        );
    }

    
    //Get address Operator, Partner and EndUser
    // Address Array
    function getOPE() public view returns(
        address[3] memory OPE
    ) {
        return (
            [operator,partner,enduser]
        );
    }

    
    //Get Equipment Batch Transaction Status
    // Equipment Transaction Status
    function getBatchIDStatus() public view returns(
        uint
    ) {
        return uint(status);
    }

    
    //Pick Equipment Batch by Associate Transporter
    // shpr Transporter Cryptocurrency Network Address
    function pickPackage(
        address shpr
    ) public {
        require(
            shpr == shipper,
            "Only Associate Shipper can call this function"
        );
        require(
            status == equipmentStatus(0),
            "Package must be at Supplier."
        );

        if(operator!=address(0x0)){
            status = equipmentStatus(1);
            emit ShippmentUpdate(address(this),shipper,operator,1,1);
        }else{
            status = equipmentStatus(2);
            emit ShippmentUpdate(address(this),shipper,partner,1,1);
        }
    }

    
    //Received Equipment Batch by Associated Operator or Partner
    // Rcvr Operator or Partner
    function receivedPackage(
        address Rcvr
    ) public
    returns(uint rcvtype)
    {

        require(
            Rcvr == operator || Rcvr == partner,
            "Only Associate Operator or Distrubuter can call this function"
        );

        require(
            uint(status) >= 1,
            "Product not picked up yet"
        );

        if(Rcvr == operator && status == equipmentStatus(1)){
            status = equipmentStatus(3);
            emit ShippmentUpdate(address(this),shipper,operator,2,3);
            return 1;
        } else if(Rcvr == partner && status == equipmentStatus(2)){
            status = equipmentStatus(4);
            emit ShippmentUpdate(address(this),shipper,partner,3,4);
            return 2;
        }
    }

    
    //Update Equipment Batch transaction Status(Pick) in between Operator and Partner
    // receiver Partner Cryptocurrency Network Address
    // sender Operator Cryptocurrency Network Address
    function sendOP(
        address receiver,
        address sender
    ) public {
        require(
            operator == sender,
            "this Operator is not Associated."
        );
        partner = receiver;
        status = equipmentStatus(2);
    }

    
    //Update Equipment Batch transaction Status(Recieved) in between Operator and Partner
    // receiver Partner
    function recievedOP(
        address receiver
    ) public {
        require(
            partner == receiver,
            "This Partner is not Associated."
        );
        status = equipmentStatus(4);
    }

    
    //Update Equipment Batch transaction Status(Pick) in between Partner and EndUser
    // receiver EndUser Cryptocurrency Network Address
    // sender Partner Cryptocurrency Network Address
    function sendPE(
        address receiver,
        address sender
    ) public {
        require(
            partner == sender,
            "this Partner is not Associated."
        );
        enduser = receiver;
        status = equipmentStatus(5);
    }

    
    //Update Equipment Batch transaction Status(Recieved) in between Partner and EndUser
    // receiver EndUser Cryptocurrency Network Address
    function recievedPE(
        address receiver
    ) public {
        require(
            enduser == receiver,
            "This EndUser is not Associated."
        );
        status = equipmentStatus(6);
    }
}