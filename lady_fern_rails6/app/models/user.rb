class User < ApplicationRecord
    has_many :purchases
    has_many :listings
    has_many :favourites
    has_many :carts
end
