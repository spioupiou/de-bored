class Game < ApplicationRecord
  has_many :games_contents
  validates :name, presence: true
end
