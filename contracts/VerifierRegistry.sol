pragma solidity ^0.4.18;


import "@aragon/os/contracts/apps/AragonApp.sol";


contract VerifierRegistry is AragonApp {
	address[] verifiers;

	function VerifierRegistry () { }

	function addVerifier() {
		verifiers.push(msg.sender);
		// some web3 stuff.
		// should call initalizeNode in nodeRegistry.
	}
}