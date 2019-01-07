pragma solidity ^0.4.24;

// TODO: Keep track of number of times an account has voted within a period

contract Voting {
    mapping (bytes32 => int) nodeScores;
    mapping (address => bytes32) addressToNodeId;

    int constant MIN_SCORE_TO_VOTE = -5;

    function addNode(bytes32 _nodeId) public returns (bool) {
        // Need to check if it already exists
        require(addressToNodeId[msg.sender] == 0, "Address already assigned a node ID");
        addressToNodeId[msg.sender] = _nodeId;
        return true;
    }

    // TODO: Should include the hash of the query conducted by the node.
    function vote(bytes32 nodeVotedOn, int delta) public returns (bool) {
        // Ensure voter is above safety threshold to vote
        require(nodeScores[addressToNodeId[msg.sender]] > MIN_SCORE_TO_VOTE);
        nodeScores[nodeVotedOn] += delta;
        return true;
    }

    function getScore() public view returns(int) {
        return nodeScores[addressToNodeId[msg.sender]];
    }

}