// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract NFTController {


  struct Auction {
    IERC721 nftToAuction;
    address NFT;
    address seller;
    uint endtime; 
    uint createTime;
  }

  mapping (uint256 => Auction) public tokenIdToAuction;

  

  function createAuction( address _nftAddress , uint256 _tokenId,  uint _endtime) external {
  
    Auction memory _auction = Auction({
       seller: msg.sender,
       createTime: block.timestamp,
       NFT: _nftAddress,
       endtime: _endtime,
       nftToAuction: IERC721(_nftAddress)
    });
     _auction.nftToAuction.safeTransferFrom(msg.sender,address(this),_tokenId);
    tokenIdToAuction[_tokenId] = _auction;
  }

  function bid( uint256 _tokenId ) external payable {
    Auction memory auction = tokenIdToAuction[_tokenId];
    require(auction.seller != address(0));
    require(auction.createTime < auction.endtime+auction.createTime);
}

  function cancel( uint256 _tokenId ) external {
    Auction memory auction = tokenIdToAuction[_tokenId];
    require(auction.seller == msg.sender);
    auction.nftToAuction.safeTransferFrom(address(this),msg.sender,_tokenId);
    delete tokenIdToAuction[_tokenId];

    
  }


}
