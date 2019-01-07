'use strict'

const logger = require("./logger.js")
const libp2p = require("libp2p")
const TCP = require("libp2p-tcp")
const PeerInfo = require("peer-info")
const waterfall = require("async/waterfall")
const defaultsDeep = require("@nodeutils/defaults-deep")
const Mplex = require("libp2p-mplex")
const SECIO = require('libp2p-secio')
const Bootstrap = require('libp2p-bootstrap')

let bootstrappers = [
	'/ip4/127.0.0.1/tcp/34663/ipfs/Qmerv7DGwe5dtZsMfhnbzPMyFwoECAio9vBqUoUj25D6g7'
]

let node

class MyBundle extends libp2p {
	constructor (_options) {
		const defaults = {
			modules: {
				transport: [TCP],
				streamMuxer: [ Mplex ],
				connEncryption: [ SECIO ],
				peerDiscovery: [ Bootstrap ]
			},
			config: { 
				peerDiscovery: {
					bootstrap: {
						interval: 2000,
						enabled: true,
						list: bootstrappers
					},
				},
				EXPERIMENTAL: {
					pubsub: true
				}
			}
		}

		super(defaultsDeep(_options, defaults))
	}
}

function createNode(callback) {
	if(cli.bootstrap) bootstrappers.push(cli.bootstrap)
	waterfall([
		(cb) => PeerInfo.create(cb),
		(peerInfo, cb) => {
			peerInfo.multiaddrs.add('/ip4/0.0.0.0/tcp/0')
			node = new MyBundle({peerInfo: peerInfo})
			node.start(cb)
		}
	], (err) => callback(err, node))
}

const printAddrs = (node) => {
		console.log("node started?", node.isStarted())
		console.log(`node ${node.peerInfo.id._idB58String} listening on:`)
		node.peerInfo.multiaddrs.forEach((ma) => console.log(ma.toString()))	
}

const publishPoolRequest = () => {
    node.pubsub.publish(
        'pool-request',
        Buffer.from("send pool number pls"),
        () => {}
    )
}

const subscribePoolRequest = () => {
    node.pubsub.subscribe('pool-request',
        async(msg) => {
        	logger.info(`pool-request received from ${msg.from}: ${msg.data.toString()}`)
        },
        () => {}
    )  
}

module.exports = { createNode, printAddrs, publishPoolRequest, subscribePoolRequest }