# myapp.rb
require 'sinatra/json'
require 'sinatra/activerecord'
require 'sinatra/base'
require 'sinatra/custom_logger'
require 'logger'

current_dir = Dir.pwd
Dir["#{current_dir}/models/*.rb"].each { |file| require file }
Dir["#{current_dir}/controllers/*.rb"].each { |file| require file }

class MyApp

    def call(env)
        path_info = env['PATH_INFO']
        app = case path_info
        when %r{^/articles} then ArticlesController.new
        when '/' then StatusController.new
          else NotFoundController.new
        end

        app.call(env)
    end

end
