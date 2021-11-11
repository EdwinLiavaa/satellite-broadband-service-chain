//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";

//// SOLUTION_P_E ////
/** @title Solution_P_E
  * @dev Sub Contract for Solution Transaction between Partner and EndUser
*/

contract Solution_P_E {
    
    string version;

    constructor(string memory _version) public {
	    console.log("Coming soon in version 2.0:", _version);
	    version = _version;
    }
}