class Admins::TemplesController < ApplicationController
  before_action :authenticate_admin!
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def show
    @temple = Temple.find(params[:id])
    @articles = @temple.articles.order(created_at: :desc).limit(3)
    set_latitude_longitude(@temple)
  end
  
  def index
    @reservation = Reservation.all
    @temples = Temple.search(params[:search]).order(:name_kana)
  end
  
  def edit
    @temple = Temple.find(params[:id])
  end

  def update
    @temple = Temple.find(params[:id])
    if @temple.update(temple_params)
      redirect_to admins_temple_path(@temple), notice: '寺院情報を更新しました。'
    else
      flash.now[:alert] = @temple.errors.full_messages.join("\n")
      render :edit
    end
  end

  def destroy
    @temple = Temple.find(params[:id])
    @temple.destroy
    redirect_to admins_temples_path, notice: '寺院を削除しました。'
  end
  
  def reservations
    @temple = Temple.find(params[:id])
    @reservations = Reservation.where(temple_id: @temple.id).where("start_time >= ?", Time.zone.today.beginning_of_day).order(:start_time)
  end
  
  def reservation
    @reservation = Reservation.find(params[:id])
    @temple = @reservation.temple
    @user = @reservation.user
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

  def temple_params
    if params[:temple][:password].blank? && params[:temple][:password_confirmation].blank?
      params[:temple].delete(:password)
      params[:temple].delete(:password_confirmation)
    end
    params.require(:temple).permit(:name, :name_kana, :postal_code, :prefecture_code, :address, :email, :phone_number, :password, :password_confirmation).except(:current_password)
  end
  
  def configure_permitted_parameters
    if admin_signed_in?
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :name_kana, :postal_code, :prefecture_code, :address, :email, :phone_number])
    else
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :name_kana, :postal_code, :prefecture_code, :address, :email, :phone_number, :password, :password_confirmation, :current_password])
    end
  end
  
  
end