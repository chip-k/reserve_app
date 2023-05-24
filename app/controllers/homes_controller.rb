class HomesController < ApplicationController
  
  def index
    @posts = Post.order(created_at: :desc).limit(3)
    @admin = Admin.find(1)
    set_latitude_longitude(@admin)
  end
  
  
  private
  
  
  def set_latitude_longitude(admin)
    result = Geocoder.search(admin.address).first
    if result.present?
      admin.latitude = result.latitude
      admin.longitude = result.longitude
    end
  end
  
end
