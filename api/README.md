<p align="center">
  <img src="../assets/images/logo_square_small.jpg?raw=true" alt="Wits University"/>
</p>

# Wits Overflow (API)

This section contains the code for the web api of the Wits Software Design project 2021.

## Getting Started

> This section is also available [here](https://github.com/gltch/wits-overflow/wiki/Getting-Started#api).


### Getting the API up and running locally

Navigate to the /api directory and run the following command:

````
npm run init
````

This will install any dependencies, generate the local Sqlite3 database 
(if it doesn't exist already) and seed the database with data.

The database can be found here:

````
/api/data/db/wits-overflow.sqlite3
````
> You can use https://sqlitebrowser.org/dl/ to browse the database.

Once this is done, run the following command to start the development 
API server (with hot reloading):

````
npm run start:dev
````

The API should then be running at the following location:

http://localhost:8080

You can try out the following endpoint to check that it is returning
data correctly:

http://localhost:8080/questions


## Useful Information

- https://github.com/gltch/wits-overflow/wiki/Useful-Links
- https://github.com/gltch/wits-overflow/wiki/Useful-Commands