class Post < ApplicationRecord
  
  belongs_to :user
  
  mount_uploader :img, ImgUploader
  
  validates :content, presence: true, length: { maximum: 1000 }
end
