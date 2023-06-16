class Admins::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def show
    @user = User.find(params[:id])
    @temple = @user.temple
  end
  
  def index
    @reservation = Reservation.all
    @users = User.search(params[:search]).order(:name_kana)
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admins_user_path(@user), notice: 'ユーザー情報を更新しました。'
    else
      flash.now[:danger] = "ユーザー情報を更新できませんでした。"
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to admins_users_path, notice: 'ユーザーを削除しました。'
    else
      flash.now[:danger] = "ユーザーを削除できませんでした。"
      render :edit
    end
  end
  
  def reservations
    @user = User.find(params[:id])
    @reservations = Reservation.where(user_id: @user.id).where("start_time >= ?", Time.zone.today.beginning_of_day).order(:start_time)
  end
  
  def reservation
    @reservation = Reservation.find(params[:id])
    @temple = @reservation.temple
    @user = @reservation.user
  end


  private

  def user_params
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    params.require(:user).permit(:name, :name_kana, :postal_code, :prefecture_code, :city, :street, :other_address, :email, :phone_number, :password, :password_confirmation).except(:current_password)
  end
  
  def configure_permitted_parameters
    if admin_signed_in?
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :name_kana, :postal_code, :prefecture_code, :city, :street, :other_address, :email, :phone_number])
    else
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :name_kana, :postal_code, :prefecture_code, :city, :street, :other_address, :email, :phone_number, :password, :password_confirmation, :current_password])
    end
  end
  
  
end
  