class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :passer, except: [:confirm]

  # before_action :evaluate, only: [:index, :confirmation]

  # def evaluate
  #   check_in = @reservation.start_date.strftime('%d')
  #   check_out = @reservation.end_date.strftime('%d')
  #   @night_count = @check_out.to_i - @check_in.to_i
  #   @day_count = @night_count + 1
  #   @total_price = @room.price * @night_count
  # end

  def index
    @reservations = @user.reservations
    @reserve_counter = @reservations.count
  end
####################################################################


  def confirm
    @user = current_user

    # @reservation = Reservation.create(reservation_params)
    # @reservation = @user.reservation.build
    @reservation = Reservation.new(reservation_params)

    @room = Room.find_by(@reservation.room_id)
    # @room = Room.find_by(id: params[:room_id])
    # @room = Room.find_by(@reservation.room_id)
    # @room = Room.find_by(params[:id])

    binding.pry

    if @reservation.invalid?
      render template: "reservations/#{@reservation.id}/confirmation"

    else
      redirect_to "/rooms/#{@reservation.room.id}/show"
      # redirect_to "/reservations/#{@reservation.id}/confirmation"
      flash[:alert] = "チェックイン日時は明日以降で選択してください" if @reservation.start_date < Date.today + 1
      flash[:alert] = "チェックアウト日時はチェックイン日時以降で選択してください" if @reservation.end_date < @reservation.start_date
    end
  end

  # def create  こっちのalertぶん使うから置いといて
  #   else
  #     redirect_to "/rooms/#{@reservation.room.id}/show"
  #     # redirect_to "/reservations/#{@reservation.id}/confirmation"
  #     # flash[:alert] = "チェックイン日時は明日以降で選択してください" if @reservation.start_date < Date.today + 1
  #     # flash[:alert] = "チェックアウト日時はチェックイン日時以降で選択してください" if @reservation.end_date < @reservation.start_date
  #   end
  # end
#####################################################################

  def show
    @reservation = Reservation.find(params[:id])
  end

  def new
    @reservation = current_user.reservations.build  #1対多の為、build
  end

  def create #validで値が正常なのしかこないからaletいらないよね？
    @reservation = current_user.reservations.build(reservation_params)
    @reservation.save
    flash[:notice] = "お部屋の予約が完了しました"
    redirect_to "/reservations/#{@reservation.id}/show"
  end

#####################################################################

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    flash[:notice] = "予約を取り消しました"
    redirect_to "/reservations"
  end

  private

  def passer
    @user = current_user
    @room = Room.find_by(params[:id])
    @reservation = Reservation.find_by(params[:id])
  end

  def reservation_params
    params.permit(:user_id, :room_id, :start_date, :end_date, :people_number, :total_price)
  end

end
