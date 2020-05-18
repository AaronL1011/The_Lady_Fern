class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :picture
  has_many :purchases, dependent: :destroy
  has_many :listings, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :carts, dependent: :destroy
  enum admin: {admin: 1, notadmin: 0}
end
