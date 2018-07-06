![Alt text](https://raw.githubusercontent.com/ChainSafeSystems/denode/master/denode.png "Optional Title")

# denode 

### overview
full nodes are needed to broadcast transactions to the ethereum network. if someone wishes to interact with the network, but doesn't want to run a full node, they would usually connect to the network through centralized providers (eg. infura). currently, there is not much incentive to run a full node.  
we wish to create a decentralized incentive for running full nodes. 

### components
DAO: adding and removing of nodes; user subscriptions and payment; payments to nodes; voting in of new rules and contracts
node verification: making sure a node is actually synced and broadcasting transactions
routing of requests: when a user wishes to send a transaction, we need to correctly decide which node to send it to
