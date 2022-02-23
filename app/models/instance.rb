class Instance < ApplicationRecord
  belongs_to :game
  belongs_to :user # host
  has_many :players, dependent: :destroy
  has_many :player_inputs, dependent: :destroy
  has_many :rounds, dependent: :destroy

  validates :status, presence: true, inclusion: { in: ['waiting', 'ongoing', 'done'] }
  validates :max_players, presence:true, numericality: { greater_than_or_equal_to: 2 }

  enum status: { waiting: 'waiting', ongoing: 'ongoing', done: 'done' }

  # find user_ids of all players in the instance except for host
  def non_host_player_user_ids
    players = Player.where(instance: self).order(id: :desc) # find all players
    user_ids = players.map(&:user_id)                       # find all player.user_id
    user_ids.delete(self.user_id)                           # remove host's user_id
    user_ids                                                # return array of user_id w/o host's user_id
  end
end
