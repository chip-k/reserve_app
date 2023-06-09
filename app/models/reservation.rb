class Reservation < ApplicationRecord
  belongs_to :temple
  belongs_to :user, optional: true

  validates :day, presence: true
  validates :time, presence: true
  
  
  # 過去または当日、翌日を選択していないか判定
  def self.check_reservation_day(day)
    if day < Time.zone.today
      return "過去の日付は選択できません。"
    elsif day == Time.zone.today || day == Time.zone.tomorrow
      return "当日、翌日は選択できません。"
    end
  end
  
  # 過去の日付を選択していないか判定
  def self.check_reservation_days(day)
    if day < Time.zone.today
      return "過去の日付は選択できません。"
    end
  end
  
  # 予約が重複していないか判定
  def self.reserved?(start_time, end_time, reservation_id = nil, temple_id)
    if reservation_id.nil?
      where("start_time < ? AND end_time > ? AND temple_id = ?", end_time, start_time, temple_id).exists?
    else
      where("start_time < ? AND end_time > ? AND id != ? AND temple_id = ?", end_time, start_time, reservation_id, temple_id).exists?
    end
  end
  
  # 開始時間より終了時間が前でないか判定
  def self.before_start_time(start_time, end_time)
    if end_time <= start_time
      return "終了時間は開始時間よりも後に設定してください。"
    end
  end
  
  # 全ての予約を取得
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
  
  # 予約ステータスの表示をtrue = "確定", false = "確認中"
  def reservation_status
    if self[:status]
      "確定"
    else
      "確認中"
    end
  end
  

end