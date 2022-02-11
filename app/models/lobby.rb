class Lobby < ApplicationRecord
  belongs_to :game
  belongs_to :user # host
  has_many :player_inputs
  has_many :players, through: :player_inputs
end
