class CallmeController < ApplicationController
  require 'twilio-ruby'
  require 'aws/s3'
  
  def index
  end
  
  # Use the Twilio REST API to initiate an outgoing call
  def makecall
      if !params['number']
          redirect_to({ :action => :makecall, 'msg' => 'Invalid phone number' })
          return
      end

      @client = get_twilio
      
      begin
          @call = @client.account.calls.create(SITE['twilio_number'], :to => params['number'], :url => request.host+'/callme/hello.xml')
      rescue StandardError => bang
          redirect_to({ :action => :makecall, 'msg' => "Error #{ bang }" })
          return
      end

      redirect_to({ :action => :makecall, 'msg' => "Calling #{ params['number'] }..." })

  end
  
  #say hi, give instructions
  def hello
  end
  
  #get their name
  def step1
  end
  
  #name is posted and recording of Rick Astley is played back
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
end
