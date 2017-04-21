class User < ApplicationRecord
  has_many :rentals, foreign_key: 'renter_id'
  validates_uniqueness_of :email, case_sensitive: false
  has_secure_password
end
