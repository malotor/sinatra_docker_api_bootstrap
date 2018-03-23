class ApplicationController < Sinatra::Base

  #helpers ApplicationHelpers

  #set :views, File.expand_path('../../views', __FILE__)
  #enable :sessions, :method_override

  #register Sinatra::Auth
  #register Sinatra::Contact
  #register Sinatra::Flash

  #use AssetHandler

  #not_found{ slim :not_found }

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
end

class NotFoundController < ApplicationController
end
