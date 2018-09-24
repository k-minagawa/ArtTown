class Artwork < ApplicationRecord
  belongs_to :user
  
  validates :user_id, presence: true
  validates :image_path, presence: true
  validates :title, presence: true, length: { maximum: 255 }
  validates :is_mature, presence: true
  
  has_many :comments, dependent: :destroy
  
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
end
