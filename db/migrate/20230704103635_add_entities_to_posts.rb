class AddEntitiesToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :entities, :text
  end
end
