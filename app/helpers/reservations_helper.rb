module ReservationsHelper
  
  def check_reservation(bookings, day, time)
    bookings.each do |booking|
      return true if booking[:day].eql?(day.strftime("%Y-%m-%d")) && booking[:time].eql?(time)
    end
    false
  end
  
end
