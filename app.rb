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

        #Permission.find_by(required_articles)
    end

    get "/articles/:id" do
        halt_if_not_found
        json @article
    end

    post '/articles' do
        @article = Article.new(required_params)
        status 422 unless @article.save
        response.headers['Location'] = "#{base_url}/articles/#{@article.id}"
        status 201
    end


    delete '/articles/:id' do
        halt_if_not_found
        @article.destroy
        status 204
    end

    put '/articles/:id' do
        halt_if_not_found
        halt 422 unless @article.update_attributes(allowed_params)
    end

    private

        def get_article
          @article ||= Article.find(params[:id])
        end

        def base_url
            @base_url ||= "#{request.env['rack.url_scheme']}://{request.env['HTTP_HOST']}"
        end

        def required_params
            error 400, 'Invalid data' unless params[:title]
            error 400, 'Invalid data' unless params[:content]

            { title: params[:title], content: params[:content] }
            #
            # filtered_params = Hash.new
            # [:title, :content].each do |filter|
            #   error 400, 'Invalid data' unless params[filter]
            #   filtered_params[filter] =  params[filter]
            # end
            # filtered_params
        end

        def allowed_params
            params.symbolize_keys.each do |key, value|
              params.delete(key) if [:title, :content].exclude? key
            end
            params.symbolize_keys
        end

        def error(code, message)
            halt code, { code: code, message: message }.to_json
        end

        def halt_if_not_found
            error 404, 'Article doesn`t exists' unless get_article
        end


end
