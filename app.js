var express = require('express');
var app = express();
var expressWs = require('express-ws')(app);
var wss = expressWs.getWss()


var clientsList = {};

app.get('/rick', (req, res) => {
  wss.clients.forEach(function each(client) {
    if (client.readyState === 1) {
      client.send("rick");
    }
  });
  res.send('Incoming Rick Roll')
})

app.get('/rick', (req, res) => {
  wss.clients.forEach(function each(client) {
    if (client.readyState === 1) {
      client.send("rick");
    }
  });
  res.send('Incoming Rick Roll')
})

app.ws('/', function(ws, req) {
  ws.on('message', function(msg) {
    clientsList[msg] = new Date().toISOString();
    console.log('clients list', clientsList)
  });
  console.log('socket', req.testing);
});

console.log("Server Live at http://localhost:3000")

app.listen(3000);