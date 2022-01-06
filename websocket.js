const fs = require('fs');
const https = require('https');
const WebSocket = require('ws');

const server = https.createServer({

    cert: fs.readFileSync('Cert/cert.pem'),

    key: fs.readFileSync('Cert/key.pem')
});



 wss = new WebSocket.Server({ server });



wss.on('connection', function connection(ws){
    console.log('connected');
    ws.on('message',function(msg){
        console.log(JSON.parse(msg));
        wss.broadcast(msg);
    });
});

wss.broadcast = function broadcast(message){
    wss.clients.forEach(function(client) {
        client.send(message);
      });
}

server.listen(8123);