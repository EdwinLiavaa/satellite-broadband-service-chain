let { networkConfig } = require('../helper-hardhat-config')

module.exports = async ({
    getNamedAccounts,
    deployments,
    getChainId
})=> {

    // This is just a convenience check
    if (network.name === "hardhat") {
      console.warn(
        "You are trying to deploy a contract to the Hardhat Network, which" +
          " gets automatically created and destroyed every time. Use the Hardhat" +
          " option '--network localhost'"
      );
    }

    // ethers is avaialble in the global scope
    const [deployer] = await ethers.getSigners();
    console.log("Deploying the contract with the account:",
    await deployer.getAddress()
  );

  console.log("Account balance:", (await deployer.getBalance()).toString());

    const { deploy, log } = deployments
    const { _deployer } = await getNamedAccounts()
    const chainId = await getChainId()

    const MyNFT = await ethers.getContractFactory("MyNFT");
    const deployedContract = await MyNFT.deploy();
    console.log("Deployed MyNFT contract address:", deployedContract.address);

    // We also save the contract's artifacts and address in the frontend directory
    saveFrontendFiles(deployedContract);
  }
  
  function saveFrontendFiles(deployedContract) {
    const fs = require("fs");
    const contractsDir = "../satellite-broadband-service-chain-ui/contract_base/contracts";
    const chaininfoDir = "../satellite-broadband-service-chain-ui/contract_base/chain-info";
  
    if (!fs.existsSync(contractsDir)) {
      fs.mkdirSync(contractsDir);
    }

    if (!fs.existsSync(chaininfoDir)) {
        fs.mkdirSync(chaininfoDir);
      }
  
    fs.writeFileSync(
        chaininfoDir + "/MyNFT-contract-address.json",
      JSON.stringify({ MyNFT: deployedContract.address }, undefined, 2)
    );

    //fs.writeFileSync(
        //chaininfoDir + "/MyNFT-chainId.json",
        //JSON.stringify({ MyNFT: getChainId() }, undefined, 2)
     // );
  
    const MyNFTArtifact = artifacts.readArtifactSync("MyNFT");
  
    fs.writeFileSync(
      contractsDir + "/MyNFT.json",
      JSON.stringify(MyNFTArtifact, null, 2)
    );
  }