class UsersController < ApplicationController
  before_action :correct_user, only: [:show]
  
  def show
    @user = User.find(params[:id])
    @temple = @user.temple
  end
  
  def assign_temple
    @temple = Temple.find(params[:id])
    if current_user.has_temple?
      redirect_to user_path(current_user), alert: "所属できる寺院は1つまでです。"
    else
      current_user.update(temple_id: @temple.id)
      redirect_to temple_path(@temple), notice: "寺院に所属しました。"
    end
  end
  
  def unassign_temple
    current_user.update(temple_id: nil)
    redirect_to user_path(current_user), notice: "所属を解除しました。"
  end
  
  private
  
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end
  
end
