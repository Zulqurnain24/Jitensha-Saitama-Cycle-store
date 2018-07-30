## Jitensha v2.0

A Jitensha REST service implementation.

## Docker Usage

- Install docker
    * https://www.docker.com/
- At root folder, run the command below:
    * docker-compose up --build

## Tools

- Install node.js and npm
    * https://nodejs.org/en/
- Install mongodb
    * https://www.mongodb.com/

# Rest api documentation

- To get more information about rest api, please refer to the doc folder
- The documentation was generated using:
    * http://apidocjs.com/

# Usage

- For proper integration, first start the mongodb database. To make the process easier, please run either, mongo-start.bat or mongo-start.sh based on your environment.

- At root folder, please run the command below to populate the database with the fake places:
    * node insert-places-test.js

- Download and install Jitensha dependencies running at root folder:
    * npm install
- The server implementation supports both, http and https communication:

    * Windows Environment
        - Http Server: set NODE_ENV=dev && node app.js
        - Https Server: node app.js
    * Unix Environment
        - Http Server: export NODE_ENV=dev && node app.js
        - Https Server: node app.js

- Software Engineer candidates should use http
- Software Architect candidates should use https
