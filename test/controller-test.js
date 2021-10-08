const { expect } = require("chai");

describe("Controller contract", function () {
  it("Deployment should allow user to deploy and acution for NFT", async function () {
    const [owner] = await ethers.getSigners();

    const NFTController = await ethers.getContractFactory("NFTController");

    const hardhatToken = await NFTController.deploy();
    
  });
});
