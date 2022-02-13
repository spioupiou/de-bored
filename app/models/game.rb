class Game < ApplicationRecord
  has_many :games_contents
  has_many :instances, dependent: :destroy
  validates :name, presence: true
end
