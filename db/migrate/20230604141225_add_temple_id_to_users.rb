class AddTempleIdToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :temple_id, :integer
  end
end
