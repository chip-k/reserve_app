class HomesController < ApplicationController
  
  def index
    @posts = Post.order(created_at: :desc).limit(3)
    @admin = Admin.find(1)
    set_latitude_longitude(@admin)
  end
  
  
  private
  
  # 管理者の住所から緯度と経度を取得しGoogleMapに表示させる
  def set_latitude_longitude(admin)
    result = Geocoder.search(admin.address).first
    if result.present?
      admin.latitude = result.latitude
      admin.longitude = result.longitude
    end
  end
  
end
