class Player < ApplicationRecord
  belongs_to :user
  belongs_to :lobby
  has_many :player_inputs
end
