class Temples::UsersController < ApplicationController
  before_action :authenticate_temple!
  
  def index
    @temple = current_temple
    @users = @temple.users.search(params[:search]).order(:name_kana)
  end
  
  def show
    @temple = current_temple
    @user = @temple.users.find(params[:id])
  end
  
  
end