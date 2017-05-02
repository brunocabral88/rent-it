class Tool < ApplicationRecord

  monetize :deposit_cents, :daily_rate_cents, numericality: true
  # mount_uploader :picture, ToolPictureUploader

  belongs_to :owner, foreign_key: 'owner_id', class_name: 'User'
  belongs_to :category
  has_many :rentals, through: :rental_items
  has_many :rental_items
  has_many :reviews, through: :rental_items

  has_attached_file :picture, styles: {
    small: "64x64", 
		med: "200x200", 
		large: "400x400",
    tiny: "100x100",
    thumb: "300x300" 
  }

  validates_presence_of :name, :description, :deposit_cents, :daily_rate_cents
  validates_attachment_content_type :picture, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]


  # Geocoding
  def full_address
    [street_address, city, province].compact.join(',')
  end

  geocoded_by :full_address, latitude: :lat, longitude: :lng
  after_validation :geocode


end