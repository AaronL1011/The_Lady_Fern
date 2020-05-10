class Listing < ApplicationRecord
  belongs_to :user
  has_many :favourites
  has_many :users, through: :favourites
  has_many :listings_purchases
  has_many :purchases, through: :listings_purchases
  has_one :size
  has_one_attached :picture
end
