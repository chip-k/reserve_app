class Admins::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def show
    @user = User.find(params[:id])
  end
  
  def index
    @users = User.all
    @reservation = Reservation.all
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admins_user_path(@user), notice: 'ユーザー情報を更新しました。'
    else
      flash.now[:alert] = @user.errors.full_messages.join("\n")
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admins_users_path, notice: 'ユーザーを削除しました。'
  end


  private

  def user_params
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    params.require(:user).permit(:name, :postal_code, :prefecture_code, :city, :street, :other_address, :email, :phone_number, :password, :password_confirmation).except(:current_password)
  end
  
  def configure_permitted_parameters
    if admin_signed_in?
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :postal_code, :prefecture_code, :city, :street, :other_address, :email, :phone_number])
    else
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :postal_code, :prefecture_code, :city, :street, :other_address, :email, :phone_number, :password, :password_confirmation, :current_password])
    end
  end
  
  
end
  