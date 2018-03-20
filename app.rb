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
            error 404,  'Article doesn`t exists'
        end
    end

    post '/articles' do
        article = Article.new(required_params)
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
            error 404, 'Article doesn`t exists'
        end
    end

    private

        helpers do

            def base_url
                @base_url ||= "#{request.env['rack.url_scheme']}://{request.env['HTTP_HOST']}"
            end

            def required_params
                error 400, 'Invalid data' unless params[:title]
                error 400, 'Invalid data' unless params[:content]

                { title: params[:title], content: params[:content] }

            end

            def error(code, message)
                halt code, { code: code, message: message }.to_json
            end
        end

end
