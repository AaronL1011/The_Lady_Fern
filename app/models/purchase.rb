class Purchase < ApplicationRecord
  belongs_to :user
  has_many :listings_purchases, dependent: :destroy
  has_many :listings, through: :listings_purchases
end
