class CallmeController < ApplicationController
  require 'twilio-ruby'
  require 'aws/s3'
  API_VERSION = '2010-04-01'
  CALLER_ID = '530-413-7840'
  BASE_URL = 'http://secretloveadventure.com/callme'
  
  def index
  end
  
  # Use the Twilio REST API to initiate an outgoing call
  def makecall
      if !params['number']
          redirect_to({ :action => '.', 'msg' => 'Invalid phone number' })
          return
      end

      begin
          @client = Twilio::REST::Client.new(SITE['twilio_account_sid'], SITE['twilio_token'])
          @call = @client.account.calls.create(:from => CALLER_ID, :to => params['number'], :url => BASE_URL + '/hello.xml')
      rescue StandardError => bang
          redirect_to({ :action => '.', 'msg' => "Error #{ bang }" })
          return
      end

      redirect_to({ :action => '', 'msg' => "Calling #{ params['number'] }..." })

  end
  
  # TwiML response that says the hellomoto to the caller and presents a
  # short menu: 1. repeat the msg, 2. directions, 3. good bye
  def hello
      @postto = BASE_URL + '/directions.xml'

      respond_to do |format|
          format.xml { @postto }
      end
  end
  
  #get their name
  def step1
  end
  
  #name is posted
  def step2
    @recordingurl = params[:RecordingUrl]
    AWS::S3::Base.establish_connection!(
        :access_key_id     => SITE['s3_access_key'], 
        :secret_access_key => SITE['s3_secret']
      )
    bucket = SITE['s3_bucket']
    file = 'Rick Astley - Never Gonna Give You Up.mp3'
    song = AWS::S3::S3Object.find file, bucket
    @rickurl = song.url(:expires_in => 30)
  end

  def rickroll
  end
end
