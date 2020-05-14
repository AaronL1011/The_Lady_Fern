class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    has_one_attached :picture
    has_many :purchases
    has_many :listings
    has_many :favourites
    has_many :carts
    enum admin: {admin: 1, notadmin: 0}
end
