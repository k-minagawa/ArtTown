class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :artwork
  
  validates :user_id, presence: true
  validates :artwork_id, presence: true
  validates :comment, presence: true, length: { maximum: 255 }
end
