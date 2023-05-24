class RemoveColumnsFromAdmins < ActiveRecord::Migration[6.1]
  def change
    remove_column :admins, :prefecture_code, :string
    remove_column :admins, :city, :string
    remove_column :admins, :street, :string
    remove_column :admins, :other_address, :string
  end
end
