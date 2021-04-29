const express = require('express');
const logger = require('morgan');
const bodyParser = require('body-parser');
const admin = require('firebase-admin')

// Set up the express app
const app = express();
const ENVIRONMENT = process.env.NODE_ENV || "development";

// Log requests to the console.
app.use(logger('dev'));

// Parse incoming requests data (https://github.com/expressjs/body-parser)
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

// Setup authorization for pre and prod environments
if ( ENVIRONMENT != 'development' ) {

    console.log(process.env.FIREBASE_PRIVATE_KEY);

    // Init firebase admin
    admin.initializeApp({
        credential: admin.credential.cert({
            "projectId": process.env.FIREBASE_PROJECT_ID,
            "private_key": process.env.FIREBASE_PRIVATE_KEY.replace(/\\n/g, '\n'),
            "client_email": process.env.FIREBASE_CLIENT_EMAIL,
        })
    });

    app.use((req, res, next) => {

        if (req.headers.token) {
    
            admin.auth().verifyIdToken(req.headers.token)
            .then(() => {
                next()
            })
            .catch(() => {
                res.status(403).send('Unauthorized')
            });
    
        }
        else {
            res.status(403).send('Unauthorized!');
        }
    
    });

}

// Routing
require('./routes')(app);

// Setup a default catch-all route that sends back a welcome message in JSON format.
app.get('*', (req, res) => res.status(200).send("API Environment: " + ENVIRONMENT));

module.exports = app;