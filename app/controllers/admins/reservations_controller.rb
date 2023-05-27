class Admins::ReservationsController < Admins::BaseController
  
  def new
    @user_id = params[:user_id]
    @user = User.find_by(id: @user_id)
    @reservation = Reservation.new
    @day = params[:day]
    @time = params[:time]
    @start_time = Time.zone.parse(@day + " " + @time).in_time_zone + 9.hours
    if Reservation.reserved?(@start_time)
      flash[:alert] = "指定された日時は既に予約済みです。"
      redirect_to reservations_path
    end
  end
  
  def create
    if params[:reservation][:user_id] == 'new'
      @reservation = Reservation.new(reservation_params.merge(new_user_name: params[:reservation][:new_user_name]))
    else
      @reservation = Reservation.new(reservation_params)
    end
    @reservation.status = false
    end_day = params[:reservation][:day]
    end_hour = params[:reservation]["end_time(4i)"]
    end_minute = params[:reservation]["end_time(5i)"]
    end_time = DateTime.parse("#{end_day} #{end_hour}:#{end_minute}")
    @reservation.end_time = end_time
    if @reservation.save
      flash[:success] = "下記の日時で仮予約を行いました。"
      redirect_to complete_reservation_path @reservation.id
    else
      render :new
    end
  end

  def reservations_by_day
    @date = params[:day] ? Date.parse(params[:day]) : Time.zone.today
    start_time = @date.beginning_of_day
    end_time = @date.end_of_day
    @reservations = Reservation.where(start_time: start_time..end_time).includes(:user)
    session[:search_date] = params[:day]
    @search_date = session[:search_date] || Time.zone.today
  end
  
  def destroy_by_day
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to admins_reservations_by_day_path(day: @reservation.start_time.to_date), notice: '予約を削除しました。'
  end
  
  def destroy
    @user = User.find(params[:user_id])
    @reservation = @user.reservations.find(params[:id])
    @reservation.destroy
    redirect_to admins_user_reservations_path(@user.id), notice: '予約を削除しました。'
  end
  
  def index
    @user = User.find(params[:user_id])
    @reservations = @user.reservations.where("start_time >= ?", Time.zone.today.beginning_of_day).order(:start_time)
    @reservation_ids = @reservations.pluck(:id)
  end
  
  def show
    @reservation = Reservation.find(params[:id])
  end
  
  def edit
    @reservation = Reservation.find(params[:id])
    @user_id = params[:user_id]
    @user = User.find_by(id: @user_id)
  end
  
  def update
    @reservation = Reservation.find(params[:id])
    if params[:reservation][:day].present?
      new_day = Date.parse(params[:reservation][:day])
      @reservation.day = new_day
      @reservation.start_time = DateTime.parse(params[:reservation][:day] + " " + params[:reservation][:time] + " " + "JST")
    end
    if params[:reservation][:user_id] == "new" && params[:reservation][:new_user_name].present?
      @reservation.new_user_name = params[:reservation][:new_user_name]
    else
      @reservation.update(reservation_params)
    end
    if @reservation.save
      updated_date = @reservation.day
      @reservations = Reservation.where(day: updated_date)
      redirect_to admins_reservations_by_day_path(day: updated_date), notice: '予約を編集しました'
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
    redirect_to edit_admins_reservation_path(@reservation, user_id: nil)
  end
  
  private
  
  def reservation_params
    params.require(:reservation).permit(:day, :time, :user_id, :start_time, :end_time, :admin_id, :status, :start_date, :end_date, :new_user_name, :comment)
  end
  
end