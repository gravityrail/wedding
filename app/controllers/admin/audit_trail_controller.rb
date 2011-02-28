class Admin::AuditTrailController < ApplicationController
  
  def show
    unless (can? :view, 'audit_trail')
      redirect_to :root
    end
    
    @versions = VestalVersions::Version.find(:all, :order => 'created_at desc')
  end
end