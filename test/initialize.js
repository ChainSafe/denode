const Kernel = artifacts.require("../node_modules/@aragon/os/contracts/kernel/Kernel.sol");

//const Kernel = artifacts.require('Kernel')

contract("Kernel", function(accounts) { 
    var addressA = accounts[0];
    var addressB = accounts[1];
    var addressC = accounts[2];
    var addressD = accounts[3];
    web3.eth.defaultAccount = web3.eth.accounts[0]

    let kernelContract;

    it("should create a kernel contract instance", async() => {
    	kernel = await Kernel.deployed();
    	console.log("\t\t kernel contract instance address: " + kernel.address);

    	assert(kernel != undefined, "has no contract instance.");
    });

});