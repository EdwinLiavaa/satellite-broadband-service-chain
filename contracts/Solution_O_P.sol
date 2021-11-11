//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";

//// SOLUTION_O_P ////
/** @title Solution_O_P
  * @dev Sub Contract for Solution Transaction between Operator and Partner
*/
contract Solution_O_P {
    
    string version;

    constructor(string memory _version) public {
	    console.log("Coming soon in version 2.0:", _version);
	    version = _version;
    }
}