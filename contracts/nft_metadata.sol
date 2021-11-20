//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";

//// NFT_METADATA ////
/** @title nft_metadata
  * @dev Create a new instance of a nft_metadata
*/

contract nft_metadata {
    
    string version;

    constructor(string memory _version) public {
	    console.log("Coming soon in version 2.0:", _version);
	    version = _version;
    }
}