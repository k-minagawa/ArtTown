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
  
  def follow(other_user)
    unless self == other_user
      self.follows.find_or_create_by(follow_id: other_user.id)
    end
  end
  
  def unfollow(other_user)
    follow = self.follows.find_by(follow_id: other_user.id)
    follow.destroy if follow
  end
  
  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def feed_artworks
    Artwork.where(user_id: self.following_ids + [self.id])
  end
  
  def like(artwork)
    self.likes.find_or_create_by(artwork_id: artwork.id)
  end
  
  def unlike(artwork)
    like = self.likes.find_by(artwork_id: artwork.id)
    like.destroy if like
  end
  
  def liking?(artwork)
    self.liking_artworks.include?(artwork)
  end
  
end
