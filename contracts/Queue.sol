pragma solidity ^0.4.18;

contract QueueContract
{
    struct Queue {
        bytes32[] data;
        uint front;
        uint back;
    }

    /// @dev the number of elements stored in the queue.
    function length(Queue q) constant internal returns (uint) {
        return q.back - q.front;
    }
    /// @dev the number of elements this queue can hold
    function capacity(Queue q) constant internal returns (uint) {
        return q.data.length - 1;
    }
    /// @dev push a new element to the back of the queue
    function push(Queue q, bytes32 data) internal
    {
        if ((q.back + 1) % q.data.length == q.front)
            return; // throw;
        q.data[q.back] = data;
        q.back = (q.back + 1) % q.data.length;
    }
    /// @dev remove and return the element at the front of the queue
    function pop(Queue q) internal returns (bytes32 r)
    {
        if (q.back == q.front)
            return; // throw;
        r = q.data[q.front];
        delete q.data[q.front];
        q.front = (q.front + 1) % q.data.length;
    }
}