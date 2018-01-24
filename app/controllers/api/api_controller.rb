class ApiController < ActionController::Base
    include Utils
    
    protect_from_forgery with: :null_session
end