class Photo < ActiveRecord::Base
  belongs_to :user
  attr_accessible :image, :user_id, :remote_image_url

  mount_uploader :image, ImageUploader
end
