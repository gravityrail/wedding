class Photo < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  has_attached_file :image, :styles => { :large => "800x800", :medium => "300x300>", :thumb => "100x100>" }
#  validates_attachment_presence :image
  
  def s3_key
    return image_file_name
  end
end
