class Reservation < ApplicationRecord
  belongs_to :admin, optional: true
  belongs_to :user, optional: true

  validates :day, presence: true
  validates :time, presence: true
  validates :start_time, presence: true, uniqueness: true
  


  def self.check_reservation_day(day)
    if day < Date.current
      return "過去の日付は選択できません。"
    elsif day < (Date.current + 1)
      return "当日は選択できません。"
    end
  end
  
  def self.check_reservation_days(day)
    if day < Date.current
      return "過去の日付は選択できません。"
    end
  end

end