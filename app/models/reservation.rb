class Reservation < ApplicationRecord
  belongs_to :admin, optional: true
  belongs_to :user, optional: true

  validates :day, presence: true
  validates :time, presence: true
  validates :start_time, uniqueness: true, allow_blank: true
  
  def self.check_reservation_day(day)
    if day < Date.current
      return "過去の日付は選択できません。"
    elsif day == Date.current
      return "当日は選択できません。"
    end
  end
  
  def self.check_reservation_days(day)
    if day < Date.current
      return "過去の日付は選択できません。"
    end
  end
  
  def self.all_reservations
    reservations = Reservation.all.order(day: :desc)
    reservation_data = []
    reservations.each do |reservation|
      reservations_hash = {}
      reservations_hash.merge!(day: reservation.day.strftime("%Y-%m-%d"), time: reservation.time)
      reservation_data.push(reservations_hash)
    end
    reservation_data
  end

end