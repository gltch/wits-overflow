// This will be our application entry. We'll setup our server here.
const http = require('http');
const app = require('../app'); // The express app we just created

console.log(process.env.DB_PRE_HOST)
console.log(process.env.DB_PRE_NAME)
console.log(process.env.DB_PRE_USER)
console.log(process.env.DB_PRE_PASSWORD)

const PORT = process.env.PORT || 8080;

app.set('port', PORT);

const server = http.createServer(app);

server.listen(PORT);