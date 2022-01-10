//---Wss-Server-----------------------------------------------------------------

const fs = require('fs');
const https = require('https');
const WebSocket = require('ws');

const server = https.createServer({

    cert: fs.readFileSync('Cert/cert.pem'),

    key: fs.readFileSync('Cert/key.pem')
});



 wss = new WebSocket.Server({ server });


//wss = new WebSocket.Server({port:8123});
unSafeSocket = new WebSocket("ws://localhost:8080");

unSafeSocket.on('message',function message(msg){
    let sendSite = JSON.parse(msg);
    if (sendSite.fromWss == false){
    sendSite.fromWss = true;
    wss.broadcast(JSON.stringify(sendSite));
    } else {
        console.log('yes');
    }
});

wss.on('connection', function connection(ws){
    console.log('connected');
    ws.on('message',function(msg){
        let newMes = JSON.parse(msg);
        //console.log(newMes);
        unSafeSocket.send(JSON.stringify(newMes));
    });
});

wss.broadcast = function broadcast(message){
    wss.clients.forEach(function(client) {
        client.send(message);
      });
}

server.listen(8123);
//------------------------------------------------------------------------------

//---Ws-Server------------------------------------------------------------------

wsss = new WebSocket.Server({port:8080});


wsss.on('connection', function connection(ws){
    console.log('connected');
    ws.on('message',function(msg){
        message = JSON.parse(msg);
        if (message.log) {
            console.log(message);
        }
        wsss.broadcast(msg);
    });
});

wsss.broadcast = function broadcast(message){
    wsss.clients.forEach(function(client) {
        client.send(message);
      });
}
