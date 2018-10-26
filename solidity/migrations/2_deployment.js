var Voting = artifacts.require("./Voting.sol");
var Registration = artifacts.require("Registration");

module.exports = function(deployer) {
    deployer.deploy(Voting)
    deployer.deploy(Registration)
};
