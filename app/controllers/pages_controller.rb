class PagesController < ApplicationController
  require 'download_users'

  before_filter :authenticate, :only => [:download_users]

  def index
    @msg = "hi!"
  end
  
  def about
  
  end
  
  def download_users
    render :csv => DownloadUsers.new, :status => :ok
#    respond_to do |format|
#      format.csv { 
#        render :csv => DownloadUsers.new, :status => :ok
#      }
#    end
  
#     #these MUST correspond to methods on User
#     headings = [
#       "id" ,
#       "email",
#       "first_name",
#       "last_name",
#       "opt_in",
#       "created_at",
#       "updated_at",
#       "language",
#       "site_language",
#       "fb_id"
#     ]
#     
#       Rails.logger.info "Processing #{name} list"
#       lines = []
#       lines << FasterCSV.generate_line(headings) 
#       
#       signatures = Signature.where(opts, :order => 'id')
#       
#       signatures.each do |signature|
#         data = headings.collect{|item| signature.send(item)}
#         lines << FasterCSV.generate_line(data)
#       end
#     
#       file = Rails.root + "/tmp/signatures-#{name}.csv"
#       f = File.open(file, 'w')
#       f.write(lines.join)
#       f.close
# 
#       s3_file_name = "#{Time.now.strftime("%m-%d-%H-%M")}-signatures-#{name}.csv"
#       AWS::S3::S3Object.store(s3_file_name, open(file), 'PurposeData', :content_type => 'text/csv')
# 
# #    Delayed::Job.enqueue BuildSignatureListJob.new
#     render :text => "building list, please stand by"
  end
end
