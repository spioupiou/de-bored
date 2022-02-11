class PlayerInput < ApplicationRecord
  belongs_to :player
  belongs_to :lobby
end
