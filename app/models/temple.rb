class Temple < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  #belongs_to :admin
  has_many :reservations, dependent: :destroy
  has_many :users, through: :reservations
  has_many :articles, dependent: :destroy
  
  def address_with_prefecture
    prefecture_code + address
  end
  
  def self.search(search)
    return Temple.all unless search
    Temple.where(['name LIKE ?', "%#{search}%"])
  end
  
end
