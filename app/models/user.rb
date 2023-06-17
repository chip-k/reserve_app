class User < ApplicationRecord
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  validates :name, presence: true
  validates :name_kana, name_kana: true
  validates :postal_code, allow_blank: true, format: { with: /\A\d{7}\z/, message: "は7桁の数字のみ入力してください。" }
  validates :phone_number, phone_number: true
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  belongs_to :temple, optional: true
  has_many :reservations, dependent: :destroy
  
  #ユーザーを部分一致で検索
  def self.search(search)
    return User.all unless search
    User.where(['name LIKE ?', "%#{search}%"])
  end
  
  #ユーザーが寺院に所属しているか判定
  def has_temple?
    temple.present?
  end
  
end
