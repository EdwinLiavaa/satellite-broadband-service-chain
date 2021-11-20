// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

//// MyNFT ////
/** @title MyNFT
  * @dev Create a new instance of a MyNFT
*/

contract MyNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    
    Counters.Counter private _tokenIds;

    constructor() ERC721("MYNFT", "TNFT") {}

    function mintToken(string memory tokenURI)
        public
        returns (uint256)
    {
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);

        return newItemId;
    }
}