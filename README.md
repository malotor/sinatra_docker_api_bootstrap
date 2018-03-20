# Ruby Sinatra REST API

REST API app with

    1. Sinatra
    2. Docker
    3. Postgresql
    4. ActiveRecord
    5. Shotgun
    6. Tux
    7. rspec
    8. capybara


## Start project

    docker-compose build
    docker-compose up -d
    chmod +x run
    sh run rake db:migrate
    sh run env RACK_ENV=test rake db:migrate

## Run Test
    sh run rspec


## Curls request

    curl -i -X GET -H "Content-Type: application/json"  http://localhost:8080
    curl -i -X GET -H "Content-Type: application/json"  http://localhost:8080/articles
    curl -i -X POST -H "Content-Type: application/json" -d'{"title":"Title1","content":"Content 1"}' http://localhost:8080/articles
