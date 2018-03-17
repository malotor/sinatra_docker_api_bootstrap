# myapp.rb
require 'sinatra'

class Application < Sinatra::Base

    set :environment, :production
    
    configure :development do
      set :database, {adapter: 'postgresql',  encoding: 'unicode', database: 'your_database_name', pool: 2, username: 'your_username', password: 'your_password'}
    end

    configure :production do
      set :database, {adapter: 'postgresql',  encoding: 'unicode', database: 'your_database_name', pool: 2, username: 'your_username', password: 'your_password'}
    end

    get '/hello/:name' do
        # matches "GET /hello/foo" and "GET /hello/bar"
        # params['name'] is 'foo' or 'bar'
        "Hello mate  experiment #{params['name']}!"
    end

end
