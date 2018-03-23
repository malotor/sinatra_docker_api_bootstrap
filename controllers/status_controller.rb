class StatusController < ApplicationController
    get "/" do
        logger.debug "Loading request"
        { status: 'UP' }.to_json
    end
end
