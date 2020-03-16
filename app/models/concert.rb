class Concert < ApplicationRecord
  include ConcertsHelper
  has_many :tickets
  has_many :users, through: :tickets

  validate :concert_after_today
end
