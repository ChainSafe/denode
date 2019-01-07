const enode = require("./lib/enode.js")
const pubsub = require("./lib/pubsub.js")
const logger = require("./lib/logger.js")
const cli = require("commander")

cli
  .version('0.1.0')
  .option('--bootstrap [name]', 'libp2p address to add to bootstrappers list')
  .option('--enode [url]', 'specify enode address')
  .parse(process.argv)

//if (!process.argv.slice(2).length) cli.help()

const startPubsub = async() => {
  return new Promise(function(resolve, reject) {
    pubsub.createNode((err, node) => {
        if (err) throw err //. todo: actual error handling
        pubsub.printAddrs(node)

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
    resolve(node)
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

  let node = await startPubsub()
}

start() 