class Review < ApplicationRecord
  belongs_to :rental_item
  has_one :rental, through: :rental_item
end