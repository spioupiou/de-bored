class GameContent < ApplicationRecord
  belongs_to :game
  validates :content, presence: true
end
