class TemplesController < ApplicationController
  before_action :authenticate_temple!, only: [:management]
  
  def show
    @temple = Temple.find(params[:id])
    @articles = @temple.articles
  end
  
  def index
    @temples = Temple.search(params[:search]).order(:name_kana)
  end
  
  def management
    @temple = Temple.find(params[:temple_id])
  end
  
  
  private
    
    def user_params
      params.require(:temple).permit(:name, :name_kana, :postal_code, :prefecture_code, :address, :latitude, :longitude, :email, :phone_number, :password, :password_confirmation)
    end
  
end