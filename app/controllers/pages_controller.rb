class PagesController < ApplicationController
  require 'download_users'

  #before_filter :authenticate, :only => [:download_users]
  before_filter :authenticate, :only => [:download_users]

  def download_users
    render :csv => DownloadUsers.new, :status => :ok
  end
  
  def user_addresses
    @users = User.where('lat IS NULL and lon IS NULL').order('last_name asc')
  end
  
  def update_user
    user = User.find(params[:id])
    
  end

  def rsvp_tahoe
    @rsvps = Array.new
    
    @tahoe = Event.find(1)
    
    Rsvp.where(:event_id => @tahoe.id).each do |r| 
      r.guests.each do |g| 
        @rsvps << "#{g.last_name}, #{g.first_name}, #{g.email}, #{r.attending}\n"
      end
    end

    @rsvps.sort!

    @rsvp_csv = "last_name, first_name, email, attending\n" 

    @rsvp_csv += @rsvps.join()

    render :template => 'pages/rsvp_csv'
  end

  def rsvp_melbourne
    @rsvps = Array.new
    
    @melbourne = Event.find(2)
    
    Rsvp.where(:event_id => @melbourne.id).each do |r| 
      r.guests.each do |g| 
        @rsvps << "#{g.last_name}, #{g.first_name}, #{g.email}, #{r.attending}\n"
      end
    end

    @rsvps.sort!

    @rsvp_csv = "last_name, first_name, email, attending\n" 

    @rsvp_csv += @rsvps.join()

    render :template => 'pages/rsvp_csv'
  end

end
