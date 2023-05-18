class Admins::ReservationsController < Admins::BaseController
  
  def new
    @reservation = Reservation.new
    @day = params[:day]
    @time = params[:time]
    @start_time = DateTime.parse(@day + " " + @time + " " + "JST")
    if Reservation.reserved?(@start_time)
      flash[:alert] = "指定された日時は既に予約済みです。"
      redirect_to reservations_path
    end
  end
  
  def create
    if params[:reservation][:user_id] == 'new'
      @reservation = Reservation.new(reservation_params.merge(user_name: params[:reservation][:new_user_name]))
    else
      @reservation = Reservation.new(reservation_params)
      if @reservation.save
        flash[:success] = "下記の日時で仮予約を行いました。"
        redirect_to reservation_path @reservation.id
      else
        render :new
      end
    end
  end

  def reservations_by_day
    if params[:from_link] == 'true'
      @date = Data.parse(params[:day])
    else
      @date = params[:day] ? Date.parse(params[:day]) : Date.today
    end
    start_time = @date.beginning_of_day
    end_time = @date.end_of_day
    @reservations = Reservation.where(start_time: start_time..end_time).includes(:user)
    session[:search_date] = params[:day]
    @search_date = session[:search_date] || Date.today
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
    @reservations = @user.reservations
  end
  
  def edit
    @reservation = Reservation.find(params[:id])
    user_options = User.pluck(:name, :id).push(["任意の名前を入力", "new"])
    existing_user_names = User.pluck(:name)
    if @reservation.new_user_name.present?
      user_options.push([@reservation.new_user_name, @reservation.new_user_name])
    end
  end
  
  def update
    @reservation = Reservation.find(params[:id])
    if params[:reservation] == "new" && params[:reservation][:new_user_name].present?
      @reservation.new_user_name = params[:reservation][:new_user_name]
    else
    @reservation.update(reservation_params)
    end
    
    if params[:reservation][:user_id] == "saienji"
      @reservation.new_user_name = "西圓寺"
    end
    @reservation.save
    updated_date = @reservation.day
    redirect_to admins_reservations_by_day_path(day: updated_date), notice: '予約を編集しました'
  end
  
  private
  
  def reservation_params
    params.require(:reservation).permit(:day, :time, :user_id, :start_time, :admin_id, :status, :start_date, :end_date, :new_user_name)
  end
  
end