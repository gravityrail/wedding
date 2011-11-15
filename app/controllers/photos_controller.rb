class PhotosController < ApplicationController
  
  def index
    @event = Event.find(params[:event_id])
    @photos = Photo.where(:event_id => @event.id)
  end
  
  def upload
    @email = params[:email]
    @event = Event.find(params[:event_id])
    @rsvp = Rsvp.for_email_at_event(@email, @event)
    @access_key_id = SITE['s3_access_key']
    
  end
  
  def show
    @photo = Photo.find(params[:id])
    
  end
  
  # create the document in rails, then send json back to our javascript to populate the form that will be
  # going to amazon.
  def create
    @event = Event.find(params[:event_id])
    @photo = Photo.new(params[:photo])
    if(@photo.save)
      render :json => {
        :policy => s3_upload_policy_document, 
        :signature => s3_upload_signature, 
        :key => @photo.s3_key, 
        :success_action_redirect => event_photo_path(@event.id, @photo.id)
      }
    else
      flash[:alert] = "Error! #{@photo.errors}"
      render :text => "Error! #{@photo.errors}"
    end
  end

  # just in case you need to do anything after the document gets uploaded to amazon.
  # but since we are sending our docs via a hidden iframe, we don't need to show the user a 
  # thank-you page.
  def s3_confirm
    head :ok
  end

  private

  # generate the policy document that amazon is expecting.
  def s3_upload_policy_document
    return @policy if @policy
    ret = {"expiration" => 5.minutes.from_now.utc.xmlschema,
      "conditions" =>  [ 
        {"bucket" =>  SITE['s3_bucket']}, 
        ["starts-with", "$key", @photo.s3_key],
        {"acl" => "private"},
        {"success_action_status" => "200"},
        ["content-length-range", 0, 1048576]
      ]
    }
    @policy = Base64.encode64(ret.to_json).gsub(/\n/,'')
  end

  # sign our request by Base64 encoding the policy document.
  def s3_upload_signature
    signature = Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest::Digest.new('sha1'), SITE['s3_access_key'], s3_upload_policy_document)).gsub("\n","")
  end
  
end
