class AddAddressToAdmins < ActiveRecord::Migration[6.1]
  def change
    add_column :admins, :address, :string
  end
end
