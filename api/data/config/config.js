require('dotenv').config();

module.exports = {

  "development": {
      "username": "ApiUser",
      "password": "admin",
      "database": "wits-overflow",
      "host": "127.0.0.1",
      "dialect": "postgres"
  },

  "test": {
      "username": "root",
      "password": null,
      "database": "database_test",
      "host": "127.0.0.1",
      "dialect": "mysql"
  },

  "production": {
      "username": "root",
      "password": null,
      "database": "database_production",
      "host": "127.0.0.1",
      "dialect": "mysql"
  }
  
};