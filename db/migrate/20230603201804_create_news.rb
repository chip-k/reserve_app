class CreateNews < ActiveRecord::Migration[6.1]
  def change
    create_table :news do |t|
      t.string :title
      t.text :content
      t.integer :temple_id

      t.timestamps
    end
  end
end
