class User < ApplicationRecord
  
  mount_uploader :img, ImgUploader
  
  before_save { self.email.downcase! }
  before_save { self.account.downcase! }
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :account, presence: true, length: { maximum: 50 },
                      format: { with: /\A[\w\-.@_]+\z/i },
                      uniqueness: { case_sensitive: false }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :phone, format: { with: /\A\d{10,11}\z/ }
  # validates :birthday, format: { with: /\A\d{4}-\d{2}-\d{2}\z/ }
  # validates :gender
  validates :intro, length: { maximum: 255 }
  # validates :img

  has_secure_password
  has_many :posts, dependent: :destroy
  
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def feed_posts
    Post.where(user_id: self.following_ids + [self.id])
  end
  
end
