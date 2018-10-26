const Registration = artifacts.require('Registration')

contract('Registration', (accounts) => {
	const addrA = accounts[0]
	let registration

	it("should register", async() => {
		registration = await Registration.deployed()
		let hash = await registration.register({from: addrA})
		assert(hash.receipt.logs.length === 1)
		assert(hash.receipt.logs[0].topics[3] - hash.receipt.logs[0].topics[2] == 60 * 60 * 24 * 7)
	})

	it("should not be able to re-register", async() => {
		try {
			let hash = await registration.register({from: addrA})
			assert(false)
		} catch (e) {
			assert(true)
		}
	})

	it("should renew the registration before it's expired", async() => {
		let expiry = await registration.expiryTime(addrA, {from: addrA})
		let hash = await registration.renew({from: addrA})
		assert(hash.receipt.logs.length === 1)
		assert(hash.receipt.logs[0].topics[3] - expiry == 60 * 60 * 24 * 7)		
	})

})