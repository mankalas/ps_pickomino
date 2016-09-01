class Game < ApplicationRecord
  # Association
  has_and_belongs_to_many :players
end
