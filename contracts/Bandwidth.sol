//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";

//// BANDWIDTH ////

/** @title Bandwidth
    @dev Create a new instance of the Bandwidth plan
*/

contract Bandwidth {
    
    string version;

    constructor(string memory _version) public {
	    console.log("Coming soon in version 2.0:", _version);
	    version = _version;
    }
}