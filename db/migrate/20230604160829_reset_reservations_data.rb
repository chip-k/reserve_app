class ResetReservationsData < ActiveRecord::Migration[6.1]
  def up
    Reservation.delete_all
  end
end
