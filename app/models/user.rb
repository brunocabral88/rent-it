class User < ApplicationRecord
  has_many :rentals, foreign_key: 'renter_id'
  validates_uniqueness_of :email, case_sensitive: false
  validates_presence_of :name, :email
  has_secure_password
end
