const request = require('request-promise')

const sendNodeRequest = async(url, method, data) => {
  let options = {
    url: url,
    method: "post",
    headers:
    { 
     "content-type": "application/json"
    },
    body: JSON.stringify( {"jsonrpc": "1.0", "id": 1, "method": method, "params": [data] })
  };

  let res = await request(options).catch((e) => {
    console.error(e)
  })
  return res
}

module.exports = {sendNodeRequest}