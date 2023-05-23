class AddNameKanaToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name_kana, :string
  end
end
