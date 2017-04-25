class Rental < ApplicationRecord
  belongs_to :renter, foreign_key: 'renter_id', primary_key: 'id', class_name: 'User'
  has_many :rental_items
  has_many :tools, through: :rental_items
  monetize :total_cents, numericality: true
  validates :stripe_charge_id, presence: true
end