class AddStatusAndCommentToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :status, :boolean, default: false
    add_column :reservations, :comment, :text
  end
end
