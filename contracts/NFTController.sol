// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "./Mocks/IERC721.sol";

contract NFTController {
IERC721 public nonFungibleContract;

  struct Auction {
    address seller;
    uint128 price;
    uint createTime;
  }

  mapping (uint256 => Auction) public tokenIdToAuction;

  function TokenAuction( address _nftAddress ) external {
    nonFungibleContract = IERC721(_nftAddress);
  }

  function createAuction( uint256 _tokenId, uint128 _price) external {
    nonFungibleContract.safeTransferFrom(msg.sender,address(this),_tokenId);
    Auction memory _auction = Auction({
       seller: msg.sender,
       price: uint128(_price),
       createTime: block.timestamp
    });
    tokenIdToAuction[_tokenId] = _auction;
  }

  function bid( uint256 _tokenId ) external payable {
    Auction memory auction = tokenIdToAuction[_tokenId];
    require(auction.seller != address(0));
    require(msg.value >= auction.price);
    require(block.timestamp < auction.createTime);
}

  function cancel( uint256 _tokenId ) external {
    Auction memory auction = tokenIdToAuction[_tokenId];
    require(auction.seller == msg.sender);

    delete tokenIdToAuction[_tokenId];

    nonFungibleContract.safeTransferFrom(address(this),msg.sender, _tokenId);
  }


}
