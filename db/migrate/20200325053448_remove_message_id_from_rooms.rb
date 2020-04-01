class RemoveMessageIdFromRooms < ActiveRecord::Migration[5.2]
  def change
    remove_column :rooms, :message_id, :integer
  end
end
