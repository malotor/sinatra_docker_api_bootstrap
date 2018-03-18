require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
require './app'

task default: %w[app:test]

namespace :app do

    task :test do
      puts "A task"
    end
    task :seed do
        seed_file = File.join('db/seeds.rb')
        load(seed_file) if File.exist?(seed_file)
    end

    desc 'Show the current environment'
        task :env do
        puts Sinatra::Application.environment
    end

end
