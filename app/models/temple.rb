class Temple < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :reservations, dependent: :destroy
  has_many :users, through: :reservations
  has_many :articles, dependent: :destroy
  
  has_one_attached :background_image
  has_one_attached :profile_image
  
  #都道府県と以降の住所を合わせる
  def address_with_prefecture
    prefecture_code + address
  end
  
  #寺院を部分検索
  def self.search(search)
    return Temple.all unless search
    Temple.where(['name LIKE ?', "%#{search}%"])
  end
  
  #プロフィール画像を設定
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
  
end
