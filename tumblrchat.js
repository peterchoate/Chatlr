var http   = require('http'),
    url    = require('url'),
    fs     = require('fs'),
    io     = require('./socket.io'),
    sys    = require('sys'),
    server = http.createServer();

server.listen(8080);
		
// socket.io, I choose you
// simplest chat application evar
var socket = io.listen(server),
    buffer = [];
		
socket.on('connection', function(client)
{
    client.send({ buffer: buffer });
    client.broadcast({ announcement: client.sessionId + ' connected' });

    client.on('message', function(message){
            var msg = { message: [client.sessionId, message] };
            buffer.push(msg);
            if (buffer.length > 15) buffer.shift();
            client.broadcast(msg);
    });

    client.on('disconnect', function(){
            client.broadcast({ announcement: client.sessionId + ' disconnected' });
    });
});
