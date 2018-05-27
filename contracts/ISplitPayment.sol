pragma solidity ^0.4.18;

//import "./SafeMath.sol";
import "./SplitPayment.sol";

/**
 * @title SplitPayment
 * @dev Base contract that supports multiple payees claiming funds sent to this contract
 * according to the proportion they own.
 */
contract ISplitPayment is SplitPayment {
	bool public isPayoutReady;
	address owner;
	address[] _payees;
	uint256[] _shares;
	function ISplitPayment() SplitPayment(_payees, _shares) {
		owner = msg.sender;
	}

	function setFlag() {
		require (msg.sender == owner);
		isPayoutReady = true;
	}
}