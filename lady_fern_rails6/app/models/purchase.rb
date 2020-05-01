class Purchase < ApplicationRecord
  belongs_to :user
  has_many :listings_purchases
  has_many :listings, through: :listings_purchases
end
