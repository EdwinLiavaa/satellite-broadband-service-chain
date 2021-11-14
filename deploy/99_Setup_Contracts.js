const { networkConfig, autoFundCheck } = require('../helper-hardhat-config')
const { ethers, getNamedAccounts } = require('hardhat')

module.exports = async ({
  getNamedAccounts,
  deployments
}) => {
  const { deploy, log, get } = deployments
  const chainId = await getChainId()
  let linkTokenAddress
  let additionalMessage = ""
  //set log level to ignore non errors
  ethers.utils.Logger.setLogLevel(ethers.utils.Logger.levels.ERROR)
  const networkName = networkConfig[chainId]['name']

  if (chainId == 31337) {
    linkToken = await get('LinkToken')
    MockOracle = await get('MockOracle')
    linkTokenAddress = linkToken.address
    oracle = MockOracle.address
    additionalMessage = " --linkaddress " + linkTokenAddress
  } else {
    linkTokenAddress = networkConfig[chainId]['linkToken']
    oracle = networkConfig[chainId]['oracle']
  }

  //Try Auto-fund APIConsumer contract with LINK
  const APIConsumer = await deployments.get('APIConsumer')
  const apiConsumer = await ethers.getContractAt('APIConsumer', APIConsumer.address)

  if (await autoFundCheck(apiConsumer.address, networkName, linkTokenAddress, additionalMessage)) {
    await hre.run("fund-link", { contract: apiConsumer.address, linkaddress: linkTokenAddress })
  } else {
    log("Then run API Consumer contract with following command:")
    log("npx hardhat request-data --contract " + apiConsumer.address + " --network " + networkName)
  }
  log("----------------------------------------------------")

}
module.exports.tags = ['all']
