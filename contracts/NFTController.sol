// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/ERC721Full.sol";

contract Controller {
ERC721 public nonFungibleContract;

  struct Auction {
    address seller;
    uint128 price;
    uint createTime;
  }

  mapping (uint256 => Auction) public tokenIdToAuction;

  function TokenAuction( address _nftAddress ) public {
    nonFungibleContract = ERC721(_nftAddress);
  }

  function createAuction( uint256 _tokenId, uint128 _price , uint256 _createTime ) public {
    nonFungibleContract.safeTransferFrom(msg.address,address(this),_tokenId);
    Auction memory _auction = Auction({
       seller: msg.sender,
       price: uint128(_price),
       createTime: _createTime
    });
    tokenIdToAuction[_tokenId] = _auction;
  }

  function bid( uint256 _tokenId ) public payable {
    Auction memory auction = tokenIdToAuction[_tokenId];
    require(auction.seller != address(0));
    require(msg.value >= auction.price);
    require(block.timestamp < createTime);



  }

  function cancel( uint256 _tokenId ) public {
    Auction memory auction = tokenIdToAuction[_tokenId];
    require(auction.seller == msg.sender);

    delete tokenIdToAuction[_tokenId];

    nonFungibleContract.safeTransferFrom(address(this),msg.sender, _tokenId);
  }


}
