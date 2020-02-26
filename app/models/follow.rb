class Follow < ApplicationRecord
  belongs_to :user
  belongs_to :venue
end
