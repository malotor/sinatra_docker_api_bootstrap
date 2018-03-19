require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
require './app'

task default: %w[app:env]

namespace :app do

    desc 'Show the current environment'
        task :env do
        puts Sinatra::Application.environment
    end

end
