const websocket = require('ws');

const wss = new ws.Server({port:8080});

wss.on('Connection', function connection(wsss){
    console.log('connected');
    wsss.on('message',function(message){
        console.log(message);
        if (message == 'f') {
            wss.send(message);
            
        }else if (message == 'b'){
            wss.send(message);
        }else if (message == 'l'){
            wss.send(message);
        }else if (message == 'r'){
            wss.send(message);
        }else {return;}
    });
})