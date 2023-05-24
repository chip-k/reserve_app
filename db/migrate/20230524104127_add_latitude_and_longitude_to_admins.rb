class AddLatitudeAndLongitudeToAdmins < ActiveRecord::Migration[6.1]
  def change
    add_column :admins, :latitude, :float
    add_column :admins, :longitude, :float
  end
end
