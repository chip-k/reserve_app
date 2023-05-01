class ReservationsController < ApplicationController
  
  def new
    @reservation = Reservation.new
    @day = params[:day]
    @time = params[:time]
    @start_time = DateTime.parse(@day + " " + @time + " " + "JST")
    message = Reservation.check_reservation_day(@day.to_date)
    if !!message
      redirect_to @reservation, flash: { alert: message }
    end
  end
  
  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      redirect_to reservation_path @reservation.id
    else
      render :new
    end
  end
  
  def show
    @reservation = Reservation.find(params[:id])
  end
  
  def index
  
  end
  
  def destroy
    @reservation = Reservation.find(params[:id])
    if @reservation.destroy
      redirect_to user_path(current_user.id), flash: { success: "予約を削除しました" }
    else
      render :show, flash: { error: "予約の削除に失敗しました" }
    end
  end
  
  def days
    @reservations = Reservation.where(day: params[:day], time: params[:time])
    @start_date = Date.today
    @times = times
    @date = params[:date]
  end
  
  
  private
  
  def reservation_params
    params.require(:reservation).permit(:day, :time, :user_id, :start_time, :admin_id, :status)
  end
  
  def times
    times = ["9:00","9:30",
             "10:00","10:30",
             "11:00","11:30",
             "12:00","12:30",
             "13:00","13:30",
             "14:00","14:30",
             "15:00","15:30",
             "16:00","16:30",
             "17:00","17:30",
             "18:00","18:30",
             "19:00","19:30",]
  end
  
end