class ChangeTempleIdToForeignKeyInUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :temple_id
    add_reference :users, :temple, foreign_key: true
  end
end
