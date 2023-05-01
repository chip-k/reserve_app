module ReservationsHelper
  
  def check_reservation(reservations, day, time)
    reservations.each do |reservation|
      return true if reservations[:day].eql?(day.strftime("%Y-%m-%d")) && reservations[:time].eql?(time)
    end
    false
  end
  
end
