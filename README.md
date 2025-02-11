# Dockerize-it

## How to run this application

1. run `yarn install`
2. create a SQL database with `docker run -p 3306:3306 -e MYSQL_ROOT_PASSWORD=test -e MYSQL_DATABASE=test -e MYSQL_USER=test -e MYSQL_PASSWORD=test -d mariadb:5.5`
3. run `yarn typeorm migration:run`
4. open `http://localhost:3000/posts` and see an empty list
5. test with `curl`, `postman` or similar tools
