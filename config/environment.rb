require 'sinatra'
require 'sinatra/json'
require 'sinatra/activerecord'
require 'sinatra/base'
require 'sinatra/custom_logger'
require 'logger'

APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))
APP_NAME = APP_ROOT.basename.to_s

def root
  File.dirname(__FILE__) + '/..'
end

def environment
    Sinatra::Application.environment
end

configure :production,:development,:test do
    enable :logging
end

# Set up the database and models
#require APP_ROOT.join('config', 'database')

# Load the routes / actions
#require APP_ROOT.join('app', 'actions')
