class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :birthday, presence: true
  has_secure_password
  
  has_many :artworks, dependent: :destroy
  
  has_many :likes, dependent: :destroy
  has_many :liking_artworks, through: :likes, source: :artwork
  
  has_many :follows, dependent: :destroy
  has_many :reverse_of_follows, class_name: "Follow", foreign_key: :follow_id, dependent: :destroy
  has_many :followings, through: :follows, source: :follow
  has_many :followers, through: :reverse_of_follows, source: :user
  
  has_many :comments, dependent: :destroy
  
end
