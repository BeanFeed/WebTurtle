const ws = require('ws');

const wss = new ws.Server({port:80});

wss.on('Connection', function(wsss){
    wsss.on('message',function(message){
        if (message == 'f') {
            wss.send(message);
        }else if (message == 'b'){
            wss.send(message);
        }else if (message == 'l'){
            wss.send(message);
        }else if (message == 'r'){
            wss.send(message);
        }else {return;}
        console.log(message);
    });
})