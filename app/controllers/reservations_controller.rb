class ReservationsController < ApplicationController
  # before_action :set_beginning_of_week
  
  def new
    @reservation = Reservation.new
    @day = params[:day]
    @time = params[:time]
    @start_time = DateTime.parse(@day + " " + @time + " " + "JST")
    message = Reservation.check_reservation_day(@day.to_date)
    if !!message
      redirect_to @reservation, flash: { danger: message }
    end
  end
  
  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      flash[:success] = "下記の日時で仮予約を行いました。"
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
      if admin_signed_in?
        redirect_to admin_path(admin.id), flash: { danger: "予約を削除しました。" }
      else
        redirect_to user_path(current_user.id), flash: { danger: "予約を削除しました。" }
      end
    else
      flash.now[:danger] = "予約の削除に失敗しました。"
      render :show 
    end
  end
  
  def week
    @date = Date.parse(params[:date])
  end
  
  
  private
  
  def reservation_params
    params.require(:reservation).permit(:day, :time, :user_id, :start_time, :admin_id, :status, :start_date, :end_date)
  end
  
  # def set_beginning_of_week
    # Date.beginning_of_week = :sunday
  # end
  
end