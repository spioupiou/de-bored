class Instance < ApplicationRecord
  belongs_to :game
  belongs_to :user # host
  has_many :player_inputs
end
