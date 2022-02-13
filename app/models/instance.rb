class Instance < ApplicationRecord
  belongs_to :game
  belongs_to :user # host
  has_many :players, dependent: :destroy
  has_many :player_inputs, dependent: :destroy
end
