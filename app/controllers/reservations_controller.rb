class ReservationsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  
  def new
    @reservation = Reservation.new
    @day = params[:day]
    @time = params[:time]
  end
  
  def create
    @reservation = Reservation.new(reservation_params)
    @start_time = Time.zone.parse(params[:reservation][:day] + " " + params[:reservation][:time])
    @reservation.start_time = @start_time
    @reservation.end_time = @reservation.start_time + 1.hour
    @end_time = @reservation.end_time
    if Reservation.reserved?(@start_time, @end_time)
      flash[:alert] = "指定された日時は既に予約済みです。"
      date = Date.current
      redirect_to reservations_week_path(date: date)
    elsif @reservation.save
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
      redirect_to reservations_path(current_user.id), flash: { danger: "予約を削除しました。" }
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
    @date_range = @date..(@date + 6.days)
    @reservations = Reservation.all
    if Reservation.check_reservation_days(@date)
      flash[:alert] = "過去の日付は選択できません。"
      render :week
    end
  end
  
  
  private
  
  def reservation_params
    params.require(:reservation).permit(:day, :time, :user_id, :start_time, :end_time, :admin_id, :status, :start_date, :end_date, :new_user_name, :comment)
  end
  
end