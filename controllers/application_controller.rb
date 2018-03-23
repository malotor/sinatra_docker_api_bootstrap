class ApplicationController < Sinatra::Base

  #helpers ApplicationHelpers

  #set :views, File.expand_path('../../views', __FILE__)
  #enable :sessions, :method_override

  #register Sinatra::Auth
  #register Sinatra::Contact
  #register Sinatra::Flash

  #use AssetHandler

  #not_found{ slim :not_found }


  before do
      content_type 'application/json'
      logger.debug "Loading request"
  end
end

class NotFoundController < ApplicationController
end
