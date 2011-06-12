class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'wedding'

  USERNAME, PASSWORD = "accessnow", "b33pb33p" #md5 of 'purpose36'
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to new_user_session_url, :alert => exception.message
  end
    
  private
  
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == USERNAME && password == PASSWORD
    end
  end
end
