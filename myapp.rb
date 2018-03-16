# myapp.rb
require 'sinatra'
require "sinatra/reloader"

set :server, "thin"
set :logging, true

set :port, 8080
set :environment, :production

get '/hello/:name' do
  # matches "GET /hello/foo" and "GET /hello/bar"
  # params['name'] is 'foo' or 'bar'
  "Hello mate  testing #{params['name']}!"
end
