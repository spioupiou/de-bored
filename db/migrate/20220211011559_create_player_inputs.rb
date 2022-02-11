class CreatePlayerInputs < ActiveRecord::Migration[6.0]
  def change
    create_table :player_inputs do |t|
      t.references :player, null: false, foreign_key: true
      t.references :lobby, null: false, foreign_key: true
      t.string :input_type
      t.text :input_value

      t.timestamps
    end
  end
end
