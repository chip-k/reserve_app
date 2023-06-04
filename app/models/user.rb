class User < ApplicationRecord
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  #belongs_to :admin
  belongs_to :temple
  has_many :reservations, dependent: :destroy
  
  def self.search(search)
    return User.all unless search
    User.where(['name LIKE ?', "%#{search}%"])
  end
  
end
