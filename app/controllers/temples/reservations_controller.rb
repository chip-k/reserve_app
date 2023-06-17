class Temples::ReservationsController < ApplicationController
  before_action :authenticate_temple!, only: [:new, :create, :index, :show, :edit, :update, :destroy, :reservations_by_day, :destroy_by_day, :all, :delete_user]

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
    @reservation.status = params[:status]
    temple_id = params[:temple_id]
    if Reservation.before_start_time(@start_time, @end_time)
      flash[:alert] = "終了時間は開始時間よりも後に設定してください。"
      redirect_to temples_reservations_by_day_path(day: @reservation.day)
    elsif Reservation.reserved?(@start_time, @end_time, temple_id)
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
    @reservations = current_temple.reservations.where(start_time: start_date..end_date).includes(:user)
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
    @reservations = @user.reservations.where("start_time >= ?", Time.zone.today.beginning_of_day).where(temple_id: current_temple.id).order(:start_time)
  end
  
  def all
    @reservations = current_temple.reservations
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
    @reservation.status = params[:status]
    temple_id = params[:temple_id]
    if params[:reservation][:user_id] == "new" && params[:reservation][:new_user_name].present?
      @reservation.new_user_name = params[:reservation][:new_user_name]
    end
    if Reservation.before_start_time(@start_time, @end_time)
      flash[:alert] = "終了時間は開始時間よりも後に設定してください。"
      redirect_to temples_reservations_by_day_path(day: @reservation.day)
    elsif Reservation.reserved?(@start_time, @end_time, @reservation.id, temple_id)
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

  def delete_user
    @reservation = Reservation.find(params[:id])
    @reservation.update(user_id: nil)
    redirect_to edit_temples_reservation_path(@reservation, user_id: nil)
  end
  
  def month
    @temple = Temple.find(params[:temple_id])
  end
  
  def week
    @temple = Temple.find(params[:temple_id])
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