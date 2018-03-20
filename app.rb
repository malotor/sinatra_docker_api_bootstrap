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
        article = Article.new(required_params)
        puts article
        if article.save
          response.headers['Location'] = "#{base_url}/articles/#{article.id}"
          status 201
        else
          status 422
        end
    end



    delete '/articles/:id' do
        begin
            Article.destroy(params[:id])
            status 204
        rescue
            halt 404, { code: 404, error: 'Article doesn`t exists' }.to_json
        end
    end



    helpers do
        def base_url
            @base_url ||= "#{request.env['rack.url_scheme']}://{request.env['HTTP_HOST']}"
        end

        def required_params
            begin
                { title: params[:title], content: params[:content] }
            rescue
                halt 400, { message:'Invalid data' }.to_json
            end
        end

    end

end
