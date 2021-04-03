// This will be our application entry. We'll setup our server here.
const http = require('http');
const app = require('../app'); // The express app we just created

const PORT = process.env.PORT || 8080;

app.set('port', PORT);

const server = http.createServer(app);

server.listen(PORT);