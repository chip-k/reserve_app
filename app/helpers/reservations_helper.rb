module ReservationsHelper
  
  def find_reservation(reservations, day, start_time, end_time)
    reservations.find do |reservation|
      reservation.start_time.to_date == day &&
        reservation.end_time.to_date == day &&
        reservation.start_time <= end_time &&
        reservation.end_time > start_time
    end
  end
  
  def times
    times = ["9:00","9:30",
            "10:00","10:30",
            "11:00","11:30",
            "12:00","12:30",
            "13:00","13:30",
            "14:00","14:30",
            "15:00","15:30",
            "16:00","16:30",
            "17:00","17:30",
            "18:00","18:30",
            "19:00","19:30",]
  end
  
end