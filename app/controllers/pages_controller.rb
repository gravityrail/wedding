class PagesController < ApplicationController
  require 'download_users'

  #before_filter :authenticate, :only => [:download_users]
  before_filter :authenticate, :only => [:download_users]

  def tahoe
    @msg = "hi!"
  end
 
  def download_users
    render :csv => DownloadUsers.new, :status => :ok
  end
end
