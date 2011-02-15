class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'access'
  before_filter :ssl_redirect

  USERNAME, PASSWORD = "accessnow", "b33pb33p" #md5 of 'purpose36'
  
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
  
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == USERNAME && password == PASSWORD
    end
  end
end
