class ChangeImpostorToImpostorUserIdInInstances < ActiveRecord::Migration[6.0]
  def change
    # just `impostor_id` can get confusing if we're using player_id or user_id
    rename_column :instances, :impostor_id, :impostor_user_id
  end
end
