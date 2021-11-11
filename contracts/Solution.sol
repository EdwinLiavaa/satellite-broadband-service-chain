//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";

/********************************************** Solution ******************************************/
/// @title Solution
/// @dev Create a new instance of a Solution

contract Solution {
    
    string version;

    constructor(string memory _version) public {
	    console.log("Coming soon in version 2.0:", _version);
	    version = _version;
    }
}