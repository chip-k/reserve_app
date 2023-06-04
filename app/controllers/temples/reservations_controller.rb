class Temples::ReservationsController < ApplicationController
  before_action :authenticate_temple!

  def new
    @user_id = params[:user_id]
    @user = User.find_by(id: @user_id)
    @reservation = Reservation.new
    @day = params[:day]
    @time = params[:time]
  end

  def create
    if params[:reservation][:user_id] == 'new'
      @reservation = Reservation.new(reservation_params.merge(new_user_name: params[:reservation][:new_user_name]))
    else
      @reservation = Reservation.new(reservation_params)
    end
    @start_time = Time.zone.parse(params[:reservation][:day] + " " + params[:reservation][:time])
    @reservation.start_time = @start_time
    @end_time = Time.zone.parse(params[:reservation][:day] + " " + params[:reservation]["end_time(4i)"] + ":" + params[:reservation]["end_time(5i)"])
    @reservation.end_time = @end_time
    if Reservation.before_start_time(@start_time, @end_time)
      flash[:alert] = "終了時間は開始時間よりも後に設定してください。"
      redirect_to temples_reservations_by_day_path(day: @reservation.day)
    elsif Reservation.reserved?(@start_time, @end_time)
      flash[:alert] = "指定された日時は既に予約済みです。"
      redirect_to temples_reservations_by_day_path(day: @reservation.day)
    elsif @reservation.save
      flash[:success] = "下記の日時で仮予約を行いました。"
      redirect_to complete_reservation_path @reservation.id
    else
      render :new
    end
  end

  def reservations_by_day
    @date = params[:day] ? Date.parse(params[:day]) : Time.zone.today
    start_date = @date.beginning_of_day
    end_date = @date.end_of_day
    @reservations = Reservation.where(start_time: start_date..end_date).includes(:user)
    session[:search_date] = params[:day]
    @search_date = session[:search_date] || Time.zone.today
  end

  def destroy_by_day
    reservation = Reservation.find(params[:id])
    if reservation.destroy
      redirect_to temples_reservations_by_day_path(day: reservation.start_time.to_date), notice: '予約を削除しました。'
    else
      render :reservations_by_day
    end
  end

  def destroy
    user = User.find(params[:user_id])
    reservation = user.reservations.find(params[:id])
    if reservation.destroy
      redirect_to temples_user_reservations_path(user.id), notice: '予約を削除しました。'
    else
      render :index
    end
  end

  def index
    @user = User.find(params[:user_id])
    @reservations = @user.reservations.where("start_time >= ?", Time.zone.today.beginning_of_day).order(:start_time)
    @reservation_ids = @reservations.pluck(:id)
  end
  
  def all
    @reservations = Reservation.all
    @sorted_reservations = @reservations.order(start_time: :asc)
  end
  
  def show
    @reservation = Reservation.find(params[:id])
  end

  def edit
    @reservation = Reservation.find(params[:id])
    start_time = @reservation.start_time
    @start_times = (9..19).flat_map { |hour| [["#{hour}:00", "#{hour}:00"], ["#{hour}:30", "#{hour}:30"]] }
    @selected_value = start_time.strftime("%H:%M")
    end_time = @reservation.end_time
    @end_times = (9..23).flat_map { |hour| [["#{hour}:00", "#{hour}:00"], ["#{hour}:30", "#{hour}:30"]] }
    @selecteds_value = end_time.strftime("%H:%M")
    user_id = params[:user_id]
    @user = User.find_by(id: user_id)
  end

  def update
    @reservation = Reservation.find(params[:id])
    @reservation.day = params[:reservation][:day]
    @start_time = Time.zone.parse(params[:reservation][:day] + " " + params[:reservation][:time])
    @reservation.start_time = @start_time
    @end_time = Time.zone.parse(params[:reservation][:day] + " " + params[:reservation]["end_times"])
    @reservation.end_time = @end_time
    @reservation.comment = params[:reservation][:comment]
    if params[:reservation][:user_id] == "new" && params[:reservation][:new_user_name].present?
      @reservation.new_user_name = params[:reservation][:new_user_name]
    end
    if Reservation.before_start_time(@start_time, @end_time)
      flash[:alert] = "終了時間は開始時間よりも後に設定してください。"
      redirect_to temples_reservations_by_day_path(day: @reservation.day)
    elsif Reservation.reserved?(@start_time, @end_time, @reservation.id)
      flash[:alert] = "指定された日時は既に予約済みです。"
      redirect_to temples_reservations_by_day_path(day: @reservation.day)
    elsif @reservation.update(reservation_params)
      updated_date = @reservation.day
      @reservations = Reservation.where(day: updated_date)
      redirect_to temples_reservations_by_day_path(day: updated_date), notice: '予約を編集しました'
    else
      render :edit
    end
  end

  def update_status
    reservation = Reservation.find(params[:reservation_id])
    new_status = params[:status] == 'true'
    if reservation.update(status: new_status)
      render json: { status: 'success' }
    else
      render json: { status: 'error' }, status: :unprocessable_entity
    end
  end

  def delete_user
    @reservation = Reservation.find(params[:id])
    @reservation.update(user_id: nil)
    redirect_to edit_temples_reservation_path(@reservation, user_id: nil)
  end
  
  def month
  end
  
  def week
    
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
    params.require(:reservation).permit(:day, :time, :user_id, :temple_id, :start_time, :end_time, :admin_id, :status, :start_date, :end_date, :new_user_name, :comment)
  end

end