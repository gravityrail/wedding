class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'wedding'

  USERNAME, PASSWORD = "accessnow", "b33pb33p" #md5 of 'purpose36'
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to new_user_session_url, :alert => exception.message
  end
  
  protected
  
    def twilio_client
      Twilio::REST::Client.new(SITE['twilio_account_sid'], SITE['twilio_token'])
    end
    
    def twilio_account
      twilio_client.account
    end
    
    def twilio_sms_dan(message)
      twilio_sms('+13474790512', message)
    end
    
    def twilio_sms_kellea(message)
      twilio_sms('+15304120204', message)
    end
    
    def twilio_sms(number, message)
      twilio_account.sms.messages.create(:from => SITE['twilio_number'], :to => number, :body => message)
    end
    
  private
  
    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
        username == USERNAME && password == PASSWORD
      end
    end
end
