class Rental < ApplicationRecord
  belongs_to :renter, foreign_key: 'renter_id', class_name: 'User'
  has_one :tool 
end
