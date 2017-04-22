class Review < ApplicationRecord
  belongs_to :rental_item
  has_one :rental, through: :rental_item
  validates_presence_of :rating, :comment
end