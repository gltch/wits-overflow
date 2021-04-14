<p align="center">
  <img src="../assets/images/logo_square.jpg?raw=true" alt="Wits University"/>
</p>

# Wits Overflow API

## Getting Started

For a description on how to get up and running, see the wiki article:
[https://github.com/gltch/wits-overflow/wiki/Getting-Started](https://github.com/gltch/wits-overflow/wiki/Getting-Started)


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

### Sequelize CLI commands:

> These are useful for doing database setup and migrations.

First things first, I suggest using a local installation of PostgreSql while
you are doing this, because it will be a lot easier to test and you can mess
around with it without affecting any other environment.

You shouldn't need to install the CLI, because it's part of the development
dependencies.

So as long as you run ``npm install`` in the api folder you should be good 
to go!

#### Creating a new model:

> Note that the model name is upper camel case and the column names are lower camel case! Also note the lack of space betwen the column names and the comma seperating them!

   ````
   npx sequelize-cli model:generate --name ModelName --attributes columnName1:string,columnName2:integer
   ````

#### Creating a new seed file (you will need to fill this out):

````
npx sequelize-cli seed:generate --name example-file-name
````

#### To run the migration:

````
npx sequelize-cli db:migrate
````

#### To roll back a particular migration:

> You can run the migrations and undo the migrations as many times as you want.

````
npx sequelize-cli db:migrate:undo
````

#### To seed the database:

````
npx sequelize-cli db:seed:all
````

#### To create associations (foreign keys):

There's unfortunately no CLI command to do this,
so you will need to manually go and edit the files before running a migration 
again.

I suggest rolling back all migrations (until it tells you there aren't any more) 
when you do this to check that the whole database is being generated correctly.

See the links below and the existing files for some examples on how to do this.

See these links for more information:

- https://sequelize.org/master/manual/migrations.html
- https://levelup.gitconnected.com/creating-sequelize-associations-with-the-sequelize-cli-tool-d83caa902233


### Docker commands:

#### Create the docker image: 

    ````
    docker build -t wits-overflow-api:v0.0.1 .
    ````

#### Create the docker container: 

    ````
    docker run --name wits-overflow-api -d -p 5545:8080 wits-overflow-api:v0.0.1
    ````