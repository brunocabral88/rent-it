class Rental < ApplicationRecord
  belongs_to :renter, foreign_key: 'renter_id', primary_key: 'id', class_name: 'User'
  has_many :rental_items
  has_many :tools, through: :rental_items
  monetize :total_cents, numericality: true
  validates :stripe_charge_id, presence: true
  validates :start_date, :end_date, presence: true, on: :create

  def total_fee
    daily_fee = 0
    daily_rate = rental_items.each do |rental_item|
      daily_fee += rental_item.tool.daily_rate_cents/100.00
    end
    renting_duration = (end_date - start_date).to_i
    daily_fee * renting_duration
  end

end