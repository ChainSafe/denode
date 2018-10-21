const Voting = artifacts.require('Voting')

contract('Voting', async (accounts) => {

    const NODE_A = 0xABCD
    const NODE_B = 0xEF01
    const NODE_A_ADDR = web3.eth.accounts[0];
    const NODE_B_ADDR = web3.eth.accounts[1];
    console.log(web3.eth.accounts[0])
    console.log(accounts)

    var voting

    it('should add a node with a starting score of zero', async () => {
        voting = await Voting.deployed()
        let res = await voting.addNode.call(NODE_A, {from: NODE_A_ADDR})
	let hash = await voting.addNode(NODE_A, {from: NODE_A_ADDR})
        console.log('Added node A')
        assert(res, 'Adding node failed.')

        res = await voting.getScore.call({from: NODE_A_ADDR})
        console.log(`Initial score is: ${res}`)
        assert(res.toString() === '0', 'Initial score not zero.')
    })

    it('should allow a node to vote on another', async () => {
        // Add a second node
        let res = await voting.addNode.call(NODE_B, {from: NODE_B_ADDR})
	let hash = await voting.addNode(NODE_B, {from: NODE_B_ADDR})
        console.log('Added node B')
        assert(res, 'Adding node failed.')

        // Let B vote on A
	res = await voting.vote.call(NODE_A, 1, {from: NODE_B_ADDR})
        hash = await voting.vote(NODE_A, 1, {from: NODE_B_ADDR})
        console.log('Submitted vote')
        assert(res, 'Submitting vote failed.')


        // Check A's new score
        res = await voting.getScore.call({from: NODE_A_ADDR})
        console.log('Got score of node A')
        assert(res == 1, `A does not have the correct score. Expected: 1; Got: ${res}`)
    })


})
