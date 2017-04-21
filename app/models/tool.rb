class Tool < ApplicationRecord
  monetize :deposit_cents, :daily_rate_cents, numericality: true
  mount_uploader :picture, ToolPictureUploader

  belongs_to :owner, foreign_key: 'owner_id', class_name: 'User'
  has_many :rentals
end