const websocket = require('ws');

wss = new websocket.Server({ port:80 });

function broadcast(message){
    wss.clients.forEach(function(client) {
        client.send(message);
      });
}
wss.on('connection', function connection(ws){
    console.log('connected');
    ws.on('message',function(msg){
        console.log(msg.toString());
        let message = msg.toString();
        if (message == 'f') {
            broadcast(message);
        }else if (message == 'b'){
            broadcast(message);
        }else if (message == 'l'){
            broadcast(message);
        }else if (message == 'r'){
            broadcast(message);
        }else {return;}
    });
})