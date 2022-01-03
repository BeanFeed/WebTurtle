const ws = require('ws');

const wss = new ws.Server({port:80});

wss.on('Connection', function(wsss){
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