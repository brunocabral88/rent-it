class Rental < ApplicationRecord
  belongs_to :renter, foreign_key: 'renter_id', class_name: 'User'
  belongs_to :tool
end
