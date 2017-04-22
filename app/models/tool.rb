class Tool < ApplicationRecord

  monetize :deposit_cents, :daily_rate_cents, numericality: true
  mount_uploader :picture, ToolPictureUploader

  belongs_to :owner, foreign_key: 'owner_id', class_name: 'User'
  belongs_to :category
  has_many :rentals, through: :rental_items
  has_many :rental_items

  validates_presence_of :name, :description, :deposit_cents, :daily_rate_cents

  # Geocoding
  def full_address
    [street_address, city, province].compact.join(',')
  end

  geocoded_by :full_address, latitude: :lat, longitude: :lng
  after_validation :geocode

end