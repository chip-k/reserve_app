class Temple < ApplicationRecord
  geocoded_by      :address
  after_validation :geocode, if: :address_changed?
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  validates :name, presence: true
  validates :name_kana, name_kana: true
  validates :postal_code, postal_code: true
  validates :prefecture_code, presence: true
  validates :address, presence: true
  validates :phone_number, phone_number: true
  validates :introduction, allow_blank: true, length: { maximum: 350 }
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :reservations, dependent: :destroy
  has_many :users,        through:   :reservations
  has_many :articles,     dependent: :destroy
  
  has_one_attached :profile_image
  
  attr_accessor :remove_profile_image
  before_save   :delete_profile_image, if: :remove_profile_image?
  
  #プロフィール画像を削除
  def delete_profile_image
    if profile_image.attached?
      profile_image.purge
    end
  end

  #プロフィール画像が削除対象か判定
  def remove_profile_image?
    remove_profile_image.present? && remove_profile_image.to_s == "1"
  end
  
  #プロフィール画像を設定
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.png')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.png', content_type: 'image/png')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
  #寺院を部分検索
  def self.search(search)
    return Temple.all unless search
    Temple.where(['name LIKE ?', "%#{search}%"])
  end
  
  #都道府県と以降の住所を合わせる
  def address_with_prefecture
    prefecture_code + address
  end
  
end
