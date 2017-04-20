class User < ApplicationRecord
  has_many :rentals, foreign_key: 'renter_id'

  has_secure_password
end
