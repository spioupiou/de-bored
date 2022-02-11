class CreateGamesData < ActiveRecord::Migration[6.0]
  def change
    create_table :games_data do |t|
      t.text :content
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
