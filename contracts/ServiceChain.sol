/** 
<<https://github.com/FidelChe/satellite-broadband-service-chain>>
*/
                                                                                 
// SPDX-License-Identifier: MIT
// Solidity code base and design adopted from work done by Kamal Kishor Mehra Blockchain : Pharmaceutical SupplyChain

pragma solidity ^0.8.0;

import "hardhat/console.sol";
import './Equipment.sol';
import './Equipment_O_P.sol';
import './Equipment_P_E.sol';
import './APIConsumer.sol';

contract ServiceChain {

    address public Owner;

    // Initiate ServiceChain Contract
    constructor () public {
        Owner = msg.sender;
    }

    //// OWNER ////

    // Validate Owner
    modifier onlyOwner() {
        require(
            msg.sender == Owner,
            "Only owner can call this function."
        );
        _;
    }

    enum roles {
        norole,
        supplier,
        transporter,
        operator,
        partner,
        enduser,
        revoke
    }
    // Events
    event UserRegister(address indexed cryptoAddress, bytes32 Name);
    event UserRoleRevoked(address indexed cryptoAddress, bytes32 Name, uint Role);
    event UserRoleRessigne(address indexed cryptoAddress, bytes32 Name, uint Role);

    /**
    * @notice Register New user by Owner
    * @param cryptoAddress Cryptocurrency Network Address of User
    * @param Name User name
    * @param Location User Location
    * @param Role User Role
    */
    function registerUser(
        address cryptoAddress,
        bytes32 Name,
        bytes32 Location,
        uint Role
        ) public
        onlyOwner
        {
        require(UsersDetails[cryptoAddress].role == roles.norole, "User Already registered");
        UsersDetails[cryptoAddress].name = Name;
        UsersDetails[cryptoAddress].location = Location;
        UsersDetails[cryptoAddress].cryptoAddress = cryptoAddress;
        UsersDetails[cryptoAddress].role = roles(Role);
        users.push(cryptoAddress);
        emit UserRegister(cryptoAddress, Name);
    }
    
    // Revoke users role
    function revokeRole(address userAddress) public onlyOwner {
        require(UsersDetails[userAddress].role != roles.norole, "User not registered");
        emit UserRoleRevoked(userAddress, UsersDetails[userAddress].name,uint(UsersDetails[userAddress].role));
        UsersDetails[userAddress].role = roles(6);
    }
    
    // Re-assign new role to User
    function reassigneRole(address userAddress, uint Role) public onlyOwner {
        require(UsersDetails[userAddress].role != roles.norole, "User not registered");
        UsersDetails[userAddress].role = roles(Role);
        emit UserRoleRessigne(userAddress, UsersDetails[userAddress].name,uint(UsersDetails[userAddress].role));
    }

    //// USER ////

    struct UserInfo {
        bytes32 name;
        bytes32 location;
        address cryptoAddress;
        roles role;
    }

    mapping(address => UserInfo) UsersDetails;
    
    address[] users;
    
    // Get User Information/Profile
    function getUserInfo(address User) public view returns(
        bytes32 name,
        bytes32 location,
        address cryptoAddress,
        roles role
        ) {
        return (
            UsersDetails[User].name,
            UsersDetails[User].location,
            UsersDetails[User].cryptoAddress,
            UsersDetails[User].role);
    }
    
    // Get Number of registered Users
    function getUsersCount() public view returns(uint count){
        return users.length;
    }

    // Get User by Index value of stored data
    // index Indexed Number
    // User Details
    function getUserbyIndex(uint index) public view returns(
        bytes32 name,
        bytes32 location,
        address cryptoAddress,
        roles role
        ) {
        return getUserInfo(users[index]);
    }

    //// SUPPLIER ////

    mapping(address => address[]) EquipmentAtSupplier;

    // Update Package / Equipment batch recieved status by ethier Supplier or Operator
    function  PackageReceived(
        address pid
    ) public {
        require(
            UsersDetails[msg.sender].role == roles.supplier,
            "Only supplier can call this function"
        );

        Equipment(pid).receivedPackage(msg.sender);
        EquipmentAtSupplier[msg.sender].push(pid);
    }

    // Get Package Count at Supplier
    // Number of Packages at Supplier
    function getPackagesCountS() public view returns(uint count){
        require(
            UsersDetails[msg.sender].role == roles.supplier,
            "Only supplier can call this function"
        );
        return EquipmentAtSupplier[msg.sender].length;
    }
    
    // Get PackageID by Indexed value of stored data
    function getPackageIDByIndexM(uint index) public view returns(address BatchID){
        require(
            UsersDetails[msg.sender].role == roles.supplier,
            "Only supplier can call this function"
        );
        return EquipmentAtSupplier[msg.sender][index];
    }

    mapping(address => address[]) EquipmentBatches;
    event EquipmentNewBatch(
        address indexed BatchId,
        address indexed Supplier,
        address shipper,
        address indexed Receiver
    );

    // Create Equipment Batch
    function packageEquipment(
        bytes32 Des,
        bytes32 RM,
        uint Quant,
        address Shpr,
        address Rcvr,
        uint RcvrType
    ) public {
        require(
            UsersDetails[msg.sender].role == roles.supplier,
            "Only supplier can call this function"
        );
        require(
            RcvrType != 0,
            "Receiver Type must be define"
        );

        Equipment m = new Equipment(
            msg.sender,
            Des,
            RM,
            Quant,
            Shpr,
            Rcvr,
            RcvrType
        );

        EquipmentBatches[msg.sender].push(address(m));
        emit EquipmentNewBatch(address(m), msg.sender, Shpr, Rcvr);
    }

    // Get Equipment Batch Count
    function getBatchesCountS() public view returns (uint count){
        require(
            UsersDetails[msg.sender].role == roles.supplier,
            "Only Supplier Can call this function."
        );
        return EquipmentBatches[msg.sender].length;
    }

    // Get Equipment BatchID by indexed value of stored data
    function getBatchIdByIndexM(uint index) public view returns(address packageID) {
        require(
            UsersDetails[msg.sender].role == roles.supplier,
            "Only Supplier Can call this function."
        );
        return EquipmentBatches[msg.sender][index];
    }

    //// TRANSPORTER ////

    // Load consingment for transport one location to another.
    function loadConsingment(
        address pid, // Package or Batch ID
        uint transportertype,
        address cid // COnsignment ID
        ) public {
        require(
            UsersDetails[msg.sender].role == roles.transporter,
            "Only Transporter can call this function"
        );
        require(
            transportertype > 0,
            "Transporter Type must be define"
        );

        if(transportertype == 1) {  // Supplier to operator
            Equipment(pid).pickPackage(msg.sender);
        } else if(transportertype == 2) {   // operator to partner 
            Equipment_O_P(pid).pickOP(pid,msg.sender);
        } else if(transportertype == 3) {   // partner to enduser
            Equipment_P_E(pid).pickPE(pid,msg.sender);
        }
    }

    //// OPERATOR ////
    
    mapping(address => address[]) EquipmentBatchesAtOperator;
    
    //Equipment Batch Received
    function equipmentReceived(
        address batchid,
        address cid
    ) public {
        require(
            UsersDetails[msg.sender].role == roles.operator || UsersDetails[msg.sender].role == roles.partner,
            "Only Operator and Partner can call this function"
        );

        uint rtype = Equipment(batchid).receivedPackage(msg.sender);
        if(rtype == 1){
            EquipmentBatchesAtOperator[msg.sender].push(batchid);
        }else if( rtype == 2){
            EquipmentBatchesAtOperator[msg.sender].push(batchid);
            if(Equipment(batchid).getOPE()[0] != address(0)){
                Equipment_O_P(cid).recieveOP(batchid,msg.sender);
            }
        }
    }

    mapping(address => address[]) EquipmentOtoP;
    mapping(address => address) EquipmentOtoPTxContract;
    
    // Sub Contract for Equipment Transfer from Operator to Partner
    function transferEquipmentOtoP(
        address BatchID,
        address Shipper,
        address Receiver
    ) public {
        require(
            UsersDetails[msg.sender].role == roles.operator &&
            msg.sender == Equipment(BatchID).getOPE()[0],
            "Only Operator or current owner of package can call this function"
        );
        Equipment_O_P op = new Equipment_O_P(
            BatchID,
            msg.sender,
            Shipper,
            Receiver
        );
        EquipmentOtoP[msg.sender].push(address(op));
        EquipmentOtoPTxContract[BatchID] = address(op);
    }

    // Get Equipment Batch Count
    function getBatchesCountOP() public view returns (uint count){
        require(
            UsersDetails[msg.sender].role == roles.operator,
            "Only Operator Can call this function."
        );
        return EquipmentOtoP[msg.sender].length;
    }

    // Get Equipment BatchID by indexed value of stored data
    function getBatchIdByIndexOP(uint index) public view returns(address packageID) {
        require(
            UsersDetails[msg.sender].role == roles.operator,
            "Only Operator Can call this function."
        );
        return EquipmentOtoP[msg.sender][index];
    }
    
    // Get Sub Contract ID of Equipment Batch Transfer in between Operator to Partner
    function getSubContractOP(address BatchID) public view returns (address SubContractOP) {
        return EquipmentOtoPTxContract[BatchID];
    }

    //// PARTNER ////
    
    mapping(address => address[]) EquipmentBatchAtPartner;
    mapping(address => address[]) EquipmentPtoE;
    mapping(address => address) EquipmentPtoETxContract;
    
    // Transfer Equipment BatchID in between Partner to EndUser
    function transferEquipmentPtoE(
        address BatchID,
        address Shipper,
        address Receiver
    ) public {
        require(
            UsersDetails[msg.sender].role == roles.partner &&
            msg.sender == Equipment(BatchID).getOPE()[1],
            "Only Partner or current owner of package can call this function"
        );
        Equipment_P_E pe = new Equipment_P_E(
            BatchID,
            msg.sender,
            Shipper,
            Receiver
        );
        EquipmentPtoE[msg.sender].push(address(pe));
        EquipmentPtoETxContract[BatchID] = address(pe);
    }
    
    // Get Equipment BatchID Count
    function getBatchesCountPE() public view returns (uint count){
        require(
            UsersDetails[msg.sender].role == roles.partner,
            "Only Partner Can call this function."
        );
        return EquipmentPtoE[msg.sender].length;
    }
    
    // Get Equipment BatchID by indexed value of stored data
    function getBatchIdByIndexPE(uint index) public view returns(address packageID) {
        require(
            UsersDetails[msg.sender].role == roles.partner,
            "Only Partner Can call this function."
        );
        return EquipmentPtoE[msg.sender][index];
    }

    // Get SubContract ID of Equipment Batch Transfer in between Partner to EndUser
    function getSubContractPE(address BatchID) public view returns (address SubContractPE) {
        return EquipmentPtoETxContract[BatchID];
    }

    //// END USER ////
    
    mapping(address => address[]) EquipmentBatchAtEndUser;
    mapping(address => equipmentstatus) settled;

    // Equipment Batch Recieved
    function EquipmentRecievedAtEndUser(
        address batchid,
        address cid
    ) public {
        require(
            UsersDetails[msg.sender].role == roles.enduser,
            "Only EndUser Can call this function."
        );
        Equipment_P_E(cid).recievePE(batchid, msg.sender);
        EquipmentBatchAtEndUser[msg.sender].push(batchid);
        settled[batchid] = equipmentstatus(1);
    }

    enum equipmentstatus {
        notfound,
        atenduser,
        paid,
        expire,
        damaged
    }

    event EquipmentStatus(
        address BatchID,
        address indexed EndUser,
        uint status
    );

    // Update Equipment Batch status
    function updateSettlementStatus(
        address BatchID,
        uint Status
    ) public {
        require(
            UsersDetails[msg.sender].role == roles.enduser &&
            msg.sender == Equipment(BatchID).getOPE()[2],
            "Only EndUser or current owner of package can call this function"
        );
        require(settled[BatchID] == equipmentstatus(1), "equipment Must be at EndUser");
        settled[BatchID] = equipmentstatus(Status);

        emit EquipmentStatus(BatchID, msg.sender, Status);
    }

    // Get Equipment Batch status
    function settlementinfo(
        address BatchID
    ) public
    view
    returns(
        uint Status
    ){
        return uint(settled[BatchID]);
    }

    // Get Equipment Batch count
    // Number of Batches
    function getBatchesCountE() public view returns(uint count){
        require(
            UsersDetails[msg.sender].role == roles.enduser,
            "Only Operator or current owner of package can call this function"
        );
        return  EquipmentBatchAtEndUser[msg.sender].length;
    }

    // Get Equipment BatchID by indexed value of stored data
    function getBatchIdByIndexE(uint index) public view returns(address BatchID){
        require(
            UsersDetails[msg.sender].role == roles.enduser,
            "Only Operator or current owner of package can call this function"
        );
        return EquipmentBatchAtEndUser[msg.sender][index];
    }
}