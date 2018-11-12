const enode = require("./lib/enode.js")
const pubsub = require("./lib/pubsub.js")
const logger = require("./lib/logger.js")

let node

const startPubsub = async() => {
  pubsub.createNode((err, _node) => {
      if (err) throw err //. todo: actual error handling
      pubsub.printAddrs(_node)
      node = _node

      node.on('peer:discovery', (peer) => {
        //logger.Info(`discovered: ${peer.id.toB58String()}`)
        node.dial(peer, () => {})
    })

    node.on('peer:connect', (peer) => {
        logger.info(`connected: ${peer.id.toB58String()}`)
        pubsub.publishPoolRequest()
    })

    node.on('peer:disconnect', (peer) => {
        logger.info(`disconnected: ${peer.id.toB58String()}`)
    })

    pubsub.subscribePoolRequest()
  })
}

const start = async() => {
  let res = await enode.getNodeInfo("http://localhost:8545")
  if(res) {
    let nodeInfo = JSON.parse(res)
    logger.info(`connected to client @ enode: ${nodeInfo.result.enode}`)
  } else {
    logger.warn(`did not connect to client`)
  }

  startPubsub()
}

start() 