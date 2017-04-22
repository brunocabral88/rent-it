class Rental < ApplicationRecord
  belongs_to :renter, foreign_key: 'renter_id', class_name: 'User'
  has_many :rental_items
  has_many :tools, through: :rental_items
end