class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'access'
  before_filter :ssl_redirect
  
  private
  
    def ssl_redirect
      if(Rails.env == 'production')
        if !request.ssl?
          redirect_to "https://" + request.host + request.request_uri
          flash.keep
          return false
        end
      end
    end
  
    
end
