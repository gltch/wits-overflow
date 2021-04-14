require('dotenv').config();

module.exports = {

    // "development": {
    //     "username": "ApiUser",
    //     "password": "admin",
    //     "database": "wits-overflow",
    //     "host": "127.0.0.1",
    //     "dialect": "postgres"
    // },
    development: {
        "dialect": "sqlite",
        "storage": "./data/db/wits-overflow.sqlite3"
    },

    "pre": {
        "username": process.env.DB_PRE_USER,
        "password": process.env.DB_PRE_PASSWORD,
        "database": process.env.DB_PRE_NAME,
        "host": process.env.DB_PRE_HOST,
        "dialect": "postgres",
            "ssl": true,
            "dialectOptions": {
                "ssl": {
                    "rejectUnauthorized": false
                }
            }
    },

    "prod": {
        "username": process.env.DB_USER,
        "password": process.env.DB_PASSWORD,
        "database": process.env.DB_NAME,
        "host": process.env.DB_HOST,
        "dialect": "postgres",
            "ssl": true,
            "dialectOptions": {
                "ssl": {
                    "rejectUnauthorized": false
                }
            }
    },
  
};