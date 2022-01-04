const websocket = require('ws');

wss = new websocket.Server({ port:8123 });


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