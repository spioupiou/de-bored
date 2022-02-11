class Game < ApplicationRecord
  has_many :games_data
  validates :name, presence: true
end
