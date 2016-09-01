class Game < ApplicationRecord
  # Association
  has_many :players
  has_many :users, through: :players
end
