const websocket = require('ws');

wss = new websocket.Server({ port:8123 });


wss.on('connection', function connection(ws){
    console.log('connected');
    ws.on('message',function(msg){
        console.log(msg.toString());
        let message = msg.toString();
        if (message == 'f') {
            wss.broadcast("turtle.forward()");
        }else if (message == 'b'){
            wss.broadcast("turtle.back()");
        }else if (message == 'l'){
            wss.broadcast("turtle.turnLeft()");
        }else if (message == 'r'){
            wss.broadcast("turtle.turnRight()");
        }else if (message == 'u') {
            wss.broadcast("turtle.up()");
        }else if (message == 'd') {
            wss.broadcast("turtle.down()")
        }else {return;}
    });
});

wss.broadcast = function broadcast(message){
    wss.clients.forEach(function(client) {
        client.send(message);
      });
}