var App = artifacts.require('./App.sol')
var NodeRegistry = artifacts.require('./NodeRegistry.sol')
//var App = artifacts.require('./App.sol')

module.exports = function (deployer) {
  deployer.deploy(App)
  deployer.deploy(NodeRegistry)
}
