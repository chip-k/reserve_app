class AddTempleIdToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :temple_id, :integer
  end
end
