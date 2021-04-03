### Getting Started

For a description on how to get up and running, see the wiki article:
[https://github.com/gltch/wits-overflow/wiki/Getting-Started](https://github.com/gltch/wits-overflow/wiki/Getting-Started)

#### Docker commands:

- Create the docker image: 

    ``docker build -t wits-overflow-api:v0.0.1 .``

- Create the docker container: 

    ``docker run --name wits-overflow-api -d -p 5545:8080 wits-overflow-api:v0.0.1``