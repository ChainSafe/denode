const utils = require("./utils.js")

// get node info by posting a request
const getNodeInfo = async(url) => {
	let res = await utils.sendNodeRequest(url, "admin_nodeInfo")
	return res
}

module.exports = {getNodeInfo}