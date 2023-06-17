class Temples::UsersController < ApplicationController
  before_action :authenticate_temple!
  
  def index
    @temple = current_temple
    subquery = @temple.reservations.select(:user_id)
    user = User.where(id: @temple.users).or(User.where(id: subquery))
    @users = user.search(params[:search]).order(:name_kana)
  end
  
  def show
    @temple = current_temple
    @user = User.find_by(id: params[:id])
    unless @user.present? && (@temple.users.include?(@user) || @temple.reservations.exists?(user_id: @user.id))
      redirect_to temple_path(@temple), alert: "閲覧する権限がありません。"
    end
  end
  
  
end