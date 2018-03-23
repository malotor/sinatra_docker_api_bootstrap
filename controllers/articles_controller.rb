class ArticlesController < ApplicationController
    #helpers Sinatra::CustomLogger
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
        add_headers
        json @article
    end

    post '/articles' do
        have_required_params?
        @article = Article.new(allowed_params)
        error(422, "Unprocesable entity") unless @article.save
        add_headers
        status 201
        json @article
    end


    delete '/articles/:id' do
        halt_if_not_found
        @article.destroy
        status 204
    end

    put '/articles/:id' do
        halt_if_not_found
        error(422, "Unprocesable entity") unless @article.update_attributes(allowed_params)
        add_headers
        json @article
    end

    private

        def get_article
          @article ||= Article.find(params[:id])
        end

        def base_url
            @base_url ||= "#{request.env['rack.url_scheme']}://{request.env['HTTP_HOST']}"
        end

        def have_required_params?
            [:title, :content].each do |param|
              error 400, "Missing param #{param}" unless params[param]
            end
        end

        def allowed_params
            params.symbolize_keys.keys.each do |param|
              params.delete(param) if [:title, :content].exclude? param
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

        def add_headers
          headers['Location'] = "#{base_url}/articles/#{@article.id}"
        end

end
