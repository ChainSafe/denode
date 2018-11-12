const request = require('request')

async function sendNodeRequest(url, method, data){
  let options = {
    url: url,
    method: "post",
    headers:
    { 
     "content-type": "application/json"
    },
    body: JSON.stringify( {"jsonrpc": "1.0", "id": 1, "method": method, "params": [data] })
  };

  request(options, (error, response, body) => {
      if (error) {
          console.error('An error has occurred: ', error);
      } else {
          console.log('Post successful: response: ', body);
          return body
      }
  });
}

module.exports = {sendNodeRequest}