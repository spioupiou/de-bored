class AddImpostorToInstance < ActiveRecord::Migration[6.0]
  def change
    remove_column :players, :imposter, :boolean
    add_reference :instances, :player, foreign_key: true
  end
end
