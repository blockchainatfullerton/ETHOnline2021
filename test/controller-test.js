const { expect } = require("chai");
const { ethers } = require("hardhat");


describe("Controller contract", function () {
  it("Should return the right name and the symbol", async function () {

    const BasicNFT = await ethers.getContractFactory("SimpleNFT");

    const BasicNFTToken = await BasicNFT.deploy("SimpleNFT","SNFT");

    await BasicNFTToken.deployed();

    expect(await BasicNFTToken.name()).to.equal("SimpleNFT");
    expect(await BasicNFTToken.symbol()).to.equal("SNFT");

  

    
  });
});
