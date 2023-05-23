class ReservationsController < ApplicationController
  
  def new
    @reservation = Reservation.new
    @day = params[:day]
    @time = params[:time]
    @start_time = DateTime.parse(@day + " " + @time + " " + "JST")
    message = Reservation.check_reservation_day(@day.to_date)
    if !!message
      redirect_to reservations_path, flash: { danger: message }
    end
    if Reservation.reserved?(@start_time)
      flash[:alert] = "指定された日時は既に予約済みです。"
      redirect_to reservations_path
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
    params.require(:reservation).permit(:day, :time, :user_id, :start_time, :admin_id, :status, :start_date, :end_date, :new_user_name)
  end
  
end