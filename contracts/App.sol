pragma solidity ^0.4.18;

import "@aragon/os/contracts/apps/AragonApp.sol";
import "./NodeRegistry.sol";
//import "./ClientRegistry.sol";
import "./VerifierRegistry.sol";
import "./SplitPayment.sol";

contract App is AragonApp {
	bytes32 public constant VERIFIER = keccak256("VERIFIER");
	bytes32 public constant NODE = keccak256("NODE");
	bytes32 public constant CLIENT = keccak256("CLIENT");

	uint constant payoutNodeThreshold = 3;

	mapping (address => uint) votesOnNode;
	mapping (address => address[]) votersOnNode;
	mapping (address => SplitPayment) payouts;

    NodeRegistry nodeRegistry;
    //ClientRegistry clientRegistry;
    VerifierRegistry verifierRegistry;
 
 	event PayoutReady(address _node);

 	/*function App(){//address _nodeRegistry, address _verifierRegistry){
 		nodeRegistry = NodeRegistry(_nodeRegistry);
 		verifierRegistry = VerifierRegistry(_verifierRegistry);
 	}*/
    function initialize(string _name) onlyInit {
        initialized();

        nodeRegistry = new NodeRegistry();
        //clientRegistry = new ClientRegistry();
        verifierRegistry = new VerifierRegistry();
    }

    function () payable {}

    function vote(address _node, bool _valid) auth(VERIFIER) returns (bool) {
    	if(nodeRegistry.nodeCoinbaseToIp(_node) != 0x0) return false;

    	address[] _payees;
		uint256[] _shares;
    	if(votersOnNode[_node].length == 0) payouts[_node] = new SplitPayment(_payees, _shares);

    	votersOnNode[_node].push(msg.sender);
    	payouts[_node].addPayee(msg.sender, 1);

    	if(_valid) votesOnNode[_node]++;
    	if(votesOnNode[_node] > 0 && !_valid) votesOnNode[_node]--;

    	//if(votesOnNode[_node] >= payoutNodeThreshold) payNode(_node);
  		return true;
    }

    function payNode(address _node) {
    	uint nodeShares = payouts[_node].totalShares();
    	nodeShares = nodeShares * 3;
    	payouts[_node].addPayee(_node, nodeShares);
    	//Emit event
    	PayoutReady(_node);
    }
}