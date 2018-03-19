# myapp.rb
require 'sinatra/json'
require 'sinatra/activerecord'
require 'sinatra/base'

current_dir = Dir.pwd
Dir["#{current_dir}/models/*.rb"].each { |file| require file }

class MyApp < Sinatra::Base

    before do
        content_type 'application/json'
    end

    get "/" do
        { status: 'UP' }.to_json
    end

    get "/articles" do
        json Article.all
    end

    get "/articles/:id" do
        begin
            json Article.find(params[:id])
        rescue
            halt 404, { code: 404, error: 'Article doesn`t exists' }.to_json
        end
    end

    post '/articles' do
        puts params
        Article.create(params[:title],params[:content])
    end

    delete '/articles/:id' do
        Article.destroy(params[:id])
    end

end
