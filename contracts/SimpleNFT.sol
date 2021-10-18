// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import "@openzeppelin/contracts/utils/Counters.sol";

import "@openzeppelin/contracts/access/Ownable.sol";

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";


contract SimpleNFT is ERC721URIStorage, Ownable {

    using Counters for Counters.Counter;

    Counters.Counter private _tokenIds;


    constructor(string memory nameNFT, string memory symbolNFT) ERC721(nameNFT, symbolNFT) {}


    function mintNFT(address recipient, string memory tokenURI)

        public onlyOwner

        returns (uint256)

    {

        _tokenIds.increment();


        uint256 newItemId = _tokenIds.current();

        _mint(recipient, newItemId);

        _setTokenURI(newItemId, tokenURI);


        return newItemId;

    }

}