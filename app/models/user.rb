class User < ApplicationRecord
  has_secure_password

  has_many :tickets
  has_many :concerts, through: :tickets

  has_many :follows
  has_many :venues, through: :follows

  validates :email, presence: true, uniqueness: true
  validates :password, :first_name, :last_name, :location, presence: true
end
