class ChangeImposterToImpostorInPlayers < ActiveRecord::Migration[6.0]
  def change
    rename_column :players, :imposter, :impostor
  end
end
