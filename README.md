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
    sh run rake db:migrate
    sh run RACK_ENV=test rake db:migrate

## Run Test
    sh run rspec
