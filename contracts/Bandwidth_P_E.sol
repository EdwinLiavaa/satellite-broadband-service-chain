//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";

/// BANDWIDTH_P_E ////
/** @title Bandwidth
  * @dev Sub Contract for Bandwidth Transaction between Partner and EndUser
*/
contract Bandwidth {
    
    string version;

    constructor(string memory _version) public {
	    console.log("Coming soon in version 2.0:", _version);
	    version = _version;
    }
}