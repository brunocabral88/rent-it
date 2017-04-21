class RentalItem < ApplicationRecord
  belongs_to :rental
  belongs_to :tool
  has_one :review
end
