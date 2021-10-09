const { expect } = require("chai");

const options = {method: 'GET'};

describe("Controller contract", function () {
  it("Deployment should allow user to deploy and acution for NFT", async function () {
    const [owner, addr1, addr2] = await ethers.getSigners();

    const NFTController = await ethers.getContractFactory("NFTController");

    const hardhatToken = await NFTController.deploy();
    
  });
});
