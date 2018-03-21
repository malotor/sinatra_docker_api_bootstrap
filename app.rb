# myapp.rb
require 'sinatra/json'
require 'sinatra/activerecord'
require 'sinatra/base'
require 'sinatra/custom_logger'
require 'logger'

current_dir = Dir.pwd
Dir["#{current_dir}/models/*.rb"].each { |file| require file }

class BaseRestApp

end

class MyApp < Sinatra::Base

    #helpers Sinatra::CustomLogger

    configure :productiom,:development do
        enable :logging
        #logger = Logger.new(File.open("#{root}/log/#{environment}.log", 'a'))
        #logger.level = Logger::DEBUG if development?
        #set :logger, logger
        #set :logger, Logger.new(STDOUT)
    end


    before do
        content_type 'application/json'
        logger.info "Loading request"
    end

    after '/post/:id' do |id|
      response.headers['Location'] = "#{base_url}/articles/#{id}"
    end


    get "/" do
        logger.debug "Loading request"
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
        have_required_params?
        @article = Article.new(allowed_params)
        status 422 unless @article.save
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

        def have_required_params?
            [:title, :content].each do |filter|
              error 400, 'Invalid data' unless params[filter]
            end
        end

        def allowed_params
            params.symbolize_keys.keys.each do |key|
              params.delete(key) if [:title, :content].exclude? key
            end
            params.symbolize_keys
        end

        def error(code, message)
            halt code, { code: code, message: message }.to_json
        end

        def halt_if_not_found
            begin
                get_article
            rescue
                error 404, 'Article doesn`t exists'
            end
        end


end
