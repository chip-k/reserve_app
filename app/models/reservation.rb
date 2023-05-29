class Reservation < ApplicationRecord
  belongs_to :admin, optional: true
  belongs_to :user, optional: true

  validates :day, presence: true
  validates :time, presence: true
  validates :start_time, uniqueness: true, allow_blank: true
  
  
  def self.check_reservation_day(day)
    if day < Time.zone.today
      return "過去の日付は選択できません。"
    elsif day == Time.zone.today || day == Time.zone.tomorrow
      return "当日、翌日は選択できません。"
    end
  end
  
  def self.check_reservation_days(day)
    if day < Time.zone.today
      return "過去の日付は選択できません。"
    end
  end
  
  def self.reserved?(start_time, end_time)
    self.where("start_time < ? AND end_time > ?", end_time, start_time).exists?
  end
  
  def self.before_start_time(start_time, end_time)
    if end_time < start_time
      return "終了時間は開始時間よりも後に設定してください。"
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
  
  def reservation_status
    if self[:status]
      "確定"
    else
      "確認中"
    end
  end
  

end