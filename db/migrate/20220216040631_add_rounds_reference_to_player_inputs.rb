class AddRoundsReferenceToPlayerInputs < ActiveRecord::Migration[6.0]
  def change
    add_reference :player_inputs, :rounds, foreign_key: true
  end
end
