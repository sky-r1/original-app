class User < ApplicationRecord
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
end
