class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password, :first_name, :last_name, :location, presence: true
end
