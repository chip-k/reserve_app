class TemplesController < ApplicationController
  before_action :authenticate_temple!, only: [:management]
  
  def show
    @temple = Temple.find(params[:id])
    @articles = @temple.articles.order(created_at: :desc).limit(3)
    set_latitude_longitude(@temple)
  end
  
  def index
    @temples = Temple.search(params[:search]).order(:name_kana)
  end
  
  def management
    @temple = Temple.find(params[:temple_id])
  end
  
  
  private
  
  # 寺院の住所から緯度と経度を取得しGoogleMapに表示させる
  def set_latitude_longitude(temple)
    result = Geocoder.search(temple.address).first
    if result.present?
      temple.latitude = result.latitude
      temple.longitude = result.longitude
    end
  end
  
end