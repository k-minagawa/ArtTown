class Like < ApplicationRecord
  belongs_to :user
  belongs_to :artwork
  
  validates :user_id, presence: true
  validates :artwork_id, presence: true
end
