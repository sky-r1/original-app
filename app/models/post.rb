class Post < ApplicationRecord
  
  belongs_to :user
  has_many :commenteds, class_name: "Comment", foreign_key: "post_id", dependent: :destroy
  has_many :commenters, through: :commented, source: :user
  
  
  mount_uploader :img, ImgUploader
  
  validates :img, presence: true
  validates :content, presence: true, length: { maximum: 1000 }
  
  def feed_comments
    Comment.where(post_id: self.commented_ids)
  end
  
end
