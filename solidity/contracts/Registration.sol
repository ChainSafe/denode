pragma solidity ^0.4.24;

contract Registration {
	// unix block timestamp of registration
	mapping (address => uint256) public timeOfRegistration;

	// time when subscription expires
	mapping (address => uint256) public expiryTime;

	// time allowed to access a node before renewal is required
	uint256 constant subscriptionTime = 7 days;

	// price to register, if needed in the future
	uint256 constant decimals = 10 ** 18;
	uint256 constant registrationPrice = 1 * decimals;

	event Registered(address indexed _addr, uint256 indexed _now, uint256 indexed _expiry);
	event Renewal(address indexed _addr, uint256 indexed _now, uint256 indexed _expiry);

	// registers msg.sender and records their time of registration
	// also, starts their first subscription
	function register() public {
		// user cannot have registered before
		require(timeOfRegistration[msg.sender] == 0);
		timeOfRegistration[msg.sender] = block.timestamp;
		expiryTime[msg.sender] = block.timestamp + subscriptionTime;
		emit Registered(msg.sender, block.timestamp, expiryTime[msg.sender]);
	}

	// renews msg.sender's subscription
	function renew() public {
		if (expiryTime[msg.sender] < now) {
			// if user's subscription time has run out, start subscription from now
			expiryTime[msg.sender] = now + subscriptionTime;
		} else {
			// if user's subscription has not run out, start subscription from old expiry time
			expiryTime[msg.sender] = expiryTime[msg.sender] + subscriptionTime;
		}
		emit Renewal(msg.sender, block.timestamp, expiryTime[msg.sender]);
	}

	// returns true if _addr has an active subscription, false otherwise
	function subscribed(address _addr) public view returns (bool) {
		return (expiryTime[_addr] < now);
	}
}