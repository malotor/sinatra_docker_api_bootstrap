# Ruby Sinatra REST API

REST API app with

    1. Sinatra
    2. Docker
    3. Postgresql
    4. ActiveRecord
    5. Shotgut
    6. Tux


# Start project

    docker-compose build
    docker-compose up -d
    sh rake.sh db:migrate

# Change environment

    RACK_ENV=production

## References

    http://recipes.sinatrarb.com/p/databases/postgresql-activerecord
    http://mherman.org/blog/2013/06/08/designing-with-class-sinatra-plus-postgresql-plus-heroku/#.Wq4lBJPwZQJ
