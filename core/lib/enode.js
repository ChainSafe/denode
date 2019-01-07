const utils = require("./utils.js")

// get node info by posting a request
const getNodeInfo = async(url) => {
	return await utils.sendNodeRequest(url, "admin_nodeInfo")
}

module.exports = {getNodeInfo}