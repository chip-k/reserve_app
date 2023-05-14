class Admins::ReservationsController < Admins::BaseController

  def reservations_by_day
    @date = params[:day] ? Date.parse(params[:day]) : Date.today
  start_time = @date.beginning_of_day
  end_time = @date.end_of_day
  @reservations = Reservation.where(start_time: start_time..end_time).includes(:user)
  end
  
  def destroy
    @user = User.find(params[:user_id])
    @reservation = @user.reservations.find(params[:id])
    @reservation.destroy
    redirect_to admins_user_reservations_path(@user.id), notice: '予約を削除しました。'
  end
  
  def index
    @user = User.find(params[:user_id])
    @reservations = @user.reservations
  end
  
end