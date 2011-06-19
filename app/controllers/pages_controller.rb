class PagesController < ApplicationController
  require 'download_users'

  #before_filter :authenticate, :only => [:download_users]
  before_filter :authenticate, :only => [:download_users]

  def download_users
    render :csv => DownloadUsers.new, :status => :ok
  end

  def rsvp_csv
    @rsvp_csv = ''
    
    Rsvp.find(:all).map do |r| 
      r.guests.each do |g| 
        @rsvp_csv += "#{r.greeting}, #{r.attending}, #{g.name}, #{g.email}\n"
      end
    end
  end
end
