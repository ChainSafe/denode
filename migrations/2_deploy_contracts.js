var App = artifacts.require('./App.sol')
/*var QueueContract = artifacts.require('./QueueContract.sol')
var NodeRegistry = artifacts.require('./NodeRegistry.sol')
var ClientRegistry = artifacts.require('./ClientRegistry.sol')
var VerifierRegistry = artifacts.require('./VerifierRegistry.sol')*/
//var Kernel = artifacts.require("../node_modules/@aragon/os/contracts/kernel/Kernel.sol");
//var ACL = artifacts.require("../node_modules/@aragon/os/contracts/acl/ACL.sol");

module.exports = function (deployer) {
	//deployer.deploy(NodeRegistry)
	//deployer.deploy(VerifierRegistry)
  	deployer.deploy(App)
}
