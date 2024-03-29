class Listing < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true

  belongs_to :user

  has_many :favourites, dependent: :destroy
  has_many :users, through: :favourites
  has_many :listings_purchases, dependent: :destroy
  has_many :carts, dependent: :destroy
  has_many :purchases, through: :listings_purchases

  has_one_attached :picture

  enum size: { "Small": 0, "Medium": 1, "Large": 2 }
end
