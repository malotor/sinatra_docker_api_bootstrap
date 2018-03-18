require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
require './app'

task default: %w[test]

task :test do
  puts "A task"
end

desc 'Show the current environment'
task :env do
  puts Sinatra::Application.environment
end


namespace :myspace do
  task :seed do
    seed_file = File.join('db/seeds.rb')
    load(seed_file) if File.exist?(seed_file)
  end
end
