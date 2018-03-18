# myapp.rb
require 'sinatra'
require 'sinatra/json'
require 'sinatra/activerecord'

current_dir = Dir.pwd
Dir["#{current_dir}/models/*.rb"].each { |file| require file }


class Application < Sinatra::Base

    #set :environment, :production
    #set :database_file, 'config/database.yml'
    get '/' do
      #json Article.all
      "Hello world"
    end
    
    get '/articles' do

      #json Article.all
      "Hello world"
    end


    get '/articles/:id' do

      json Article.find(params[:id])

    end

    post '/articles' do

      Article.create(params[:article])

    end

    delete '/articles/:id' do
      Article.destroy(params[:id])
    end

end
