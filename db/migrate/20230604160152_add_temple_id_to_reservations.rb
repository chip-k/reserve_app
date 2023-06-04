class AddTempleIdToReservations < ActiveRecord::Migration[6.1]
  def change
    add_reference :reservations, :temple, foreign_key: true
  end
end
