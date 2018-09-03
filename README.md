![Alt text](https://raw.githubusercontent.com/ChainSafeSystems/denode/master/denode.png "Optional Title")

# denode

> Huge thanks to the ECF for helping to fund this project! <3

## Overview
To use the Ethereum network today, as a user and a developer, one needs to use Infura or have to setup and maintain a node themselves. In its current state, Infura is a centralized service that facilitates access to Ethereum and is an almost essential component of it. Being the only reliable service that provides such essential tools, Infura poses a risk to the Ethereum blockchain as it provides centralized access to a decentralized blockchain, essentially withering away the benefits of decentralization.

To address this issue, ChainSafe introduces Denode, a fully decentralized, open-source solution that simplifies access to Ethereum in a safe and reliable manner and incentivizes users to run full nodes. Denode introduces monetary incentives for running full nodes in a decentralized manner as a mechanism for improving the security and stability of the network.


## Road Map
The project consists of five main components, some of which can be concurrent, and others which are consecutive.

### Component One: Research and Development (1 month)
- Outline a precise application flow and architecture
- Explore the potential vulnerabilities of the system
- Evaluate the mechanism design of the system in regards to incentivisation systems
- Develop a token system to manage access to the nodes

### Component Two: DAO development (1 month)
- Create Access Control Registries (ACR)
- Implement a voting system for verifying nodes
- Enable the retrieval of Node IPs
- Establish a payout contract to compensate the nodes

### Component Three: Nodestats and Integration (2 months)
Build a mechanism that:
- Allows nodes to submit requests to each other and verify the results
- Maintains a copy of the ACR for a node
- Verifies access tokens in requests
- Integrates with the DAO

### Component Four: Testing, Documentation and QA (1 month)
- Setup a testnet
- Perform stress tests and fuzzy testing
- Ensure documentation is up to date and accessible to the community

### Component Five: User Interface (UI) design (2 weeks)
- Designing and implementing a simple web UI to allow users to gain access to the network

### Component Six: Community Engagement and Marketing
- Engage developers for feedback and auditing
- Incentivise users to migrate

>info@chainsafe.io
