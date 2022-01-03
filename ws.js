var WebSocketServer = require('ws').Server;

wss = new WebSocketServer({ port: 8123 });

wss.on('connection', function connection(ws) {
  ws.on('message', function incoming(message) {
    console.log(message);
    let newMSG = JSON.parse(message);
    console.log(newMSG);
    console.log(message.data);
    ws.send(message);
  });
});