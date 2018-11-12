const enode = require("./lib/enode.js")

const start = async() => {
  let res = await enode.getNodeInfo("http://localhost:8545")
  if(res) console.log(res)
}

start()