pragma solidity ^0.4.24;

contract Registration {
	// unix block timestamp of registration
	mapping (address => uint256) timeOfRegistration;

	// time when subscription expires
	mapping (address => uint256) expiryTime;

	// time allowed to access a node before renewal is required
	constant uint256 subscriptionTime = 7 days;

	// price to register, if needed in the future
	constant uint256 decimals = 10 ** 18;
	constant uint256 registrationPrice = 1 * decimals;

	event Registration(address _addr, uint256 _timestamp);
	event Renewal(address _addr, uint256 _timestamp);

	// registers msg.sender and records their time of registration
	// as well, a hash of their password must be submitted
	function register() public {
		// user cannot have registered before
		require(timeOfRegistration[msg.sender] == 0);
		timeOfRegistration[msg.sender] = block.timestamp;
		expiryTime[msg.sender] = block.timestamp + subscriptionTime;
		emit Registration(msg.sender, block.timestamp);
	}

	function renew() public {
		if (expiryTime[msg.sender] < now) {
			// if user's subscription time has run out, start subscription from now
			expiryTime[msg.sender] = now + subscriptionTime;
		} else {
			// if user's subscription has not run out, start subscription from old expiry time
			expiryTime[msg.sender] = expiryTime + subscriptionTime;
		}
		emit Renewal(msg.sender, block.timestamp);
	}
}