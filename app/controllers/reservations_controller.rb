class ReservationsController < ApplicationController
  
  def new
    @reservation = Reservation.new
    @status = false
    @day = params[:day]
    @time = params[:time]
    @start_time = Time.zone.parse(@day + " " + @time).in_time_zone + 9.hours
    @end_time = @start_time + 30.minutes
    if Reservation.reserved?(@start_time)
      flash[:alert] = "指定された日時は既に予約済みです。"
      redirect_to reservations_path
    end
  end
  
  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      flash[:success] = "下記の日時で予約を行いました。"
      redirect_to complete_reservation_path @reservation.id
    else
      render :new
    end
  end
  
  def complete
    @reservation = Reservation.find(params[:id])
  end
  
  def show
    @reservation = Reservation.find(params[:id])
    @admin = Admin.find(1)
  end
  
  def index
    user_id = current_user.id
    @reservations = Reservation.where(user_id: user_id).where("start_time >= ?", Time.zone.today.beginning_of_day).order(:start_time)
    @admin = Admin.find(1)
  end
  
  def destroy
    @reservation = Reservation.find(params[:id])
    if @reservation.destroy
      if admin_signed_in?
        redirect_to reservations_path(@user), flash: { danger: "予約を削除しました。" }
      else
        redirect_to reservations_path(current_user.id), flash: { danger: "予約を削除しました。" }
      end
    else
      flash.now[:danger] = "予約の削除に失敗しました。"
      render :show 
    end
  end
  
  def month
  end
  
  def week
    @admin = Admin.find(1)
    @date = Date.parse(params[:date])
    if Reservation.check_reservation_days(@date)
      flash[:alert] = "過去の日付は選択できません。"
      redirect_to reservations_path
    end
  end
  
  
  private
  
  def reservation_params
    params.require(:reservation).permit(:day, :time, :user_id, :start_time, :end_time, :admin_id, :status, :start_date, :end_date, :new_user_name, :comment)
  end
  
end