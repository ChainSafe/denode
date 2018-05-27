pragma solidity ^0.4.18;
pragma experimental ABIEncoderV2;

//import "./QueueContract.sol";
import "@aragon/os/contracts/apps/AragonApp.sol";
import "@aragon/os/contracts/acl/ACL.sol";


contract NodeRegistry is AragonApp {
	bytes32 public constant VERIFIER = keccak256("VERIFIER");
	bytes32 public constant NODE = keccak256("NODE");
	bytes32 public constant CLIENT = keccak256("CLIENT");

	mapping (address => bytes32) public nodeCoinbaseToIp; // rlp-encoded ip:port to coinbase address
	mapping (bytes32 => address) nodeIpToCoinbase;
	Queue nodeQueue;

	function getNodeCoinbaseToIp(address _a) public returns (bytes32) {
		return nodeCoinbaseToIp[_a];
	}
    struct Queue {
        bytes32[] data;
        uint front;
        uint back;
    }
/*
	function isRegistered(bytes32 _ip) returns (bool) {
		if (nodeIpToCoinbase[_ip] == 0x0) return false;
		else return true;
	}

	// queue node for verification.
	// @params: bytes32 rlp-encoded ip address
	function queueNode(bytes32 _ip) returns (bool) {
		if(isRegistered(_ip)) return false;

		push(nodeQueue, _ip);
		return true;
	}

	function dequeueNode() auth(VERIFIER) returns (bytes32) {
		return pop(nodeQueue);
	}

	// verifier gets coinbase address from web3 as part of its initialization
	// assume verifier is honest ?
	function initalizeNode(address _coinbase, bytes32 _ip) auth(VERIFIER) returns (bool) {
		if(_coinbase == address(0)) return false;
		nodeCoinbaseToIp[_coinbase] = _ip;
		return true;
	}

	/// @dev the number of elements stored in the queue.
    function length(Queue q) constant returns (uint) {
        return q.back - q.front;
    }

    /// @dev the number of elements this queue can hold
    function capacity(Queue q) constant returns (uint) {
        return q.data.length - 1;
    }

    /// @dev push a new element to the back of the queue
    function push(Queue q, bytes32 data) private
    {
        if ((q.back + 1) % q.data.length == q.front)
            return; // throw;
        q.data[q.back] = data;
        q.back = (q.back + 1) % q.data.length;
    }
    
    /// @dev remove and return the element at the front of the queue
    function pop(Queue q) private returns (bytes32 r)
    {
        if (q.back == q.front)
            return; // throw;
        r = q.data[q.front];
        delete q.data[q.front];
        q.front = (q.front + 1) % q.data.length;
    }*/
}