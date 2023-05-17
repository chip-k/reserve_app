class AddNewUserNameToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :new_user_name, :string
  end
end
