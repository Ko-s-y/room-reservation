class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :passer

  def index
    @reservations = @user.reservations
    @reserve_counter = @reservations.count
  end

  def new
    @user = current_user
    @reservation = Reservation.new(reservation_params)
    @room = Room.find_by(id: @reservation.room_id)
    render template: "rooms/show" if @reservation.invalid?
    binding.pry
  end

  def create
    binding.pry
    @reservation = Reservation.new(reservation_params)
    # @reservation = current_user.reservations.build(reservation_params)
    @room = Room.find_by(id: @reservation.room_id)
    binding.pry
    if @reservation.save
      binding.pry
      flash[:notice] = "お部屋の予約が完了しました"
      redirect_to "/reservations/#{@reservation.id}/show"
    else
      binding.pry
      flash.now[:alert] = "予約できませんでした"
      render "rooms/show"
    end
  end

  # def create   ここのalert残して置いて！！
  #   else
  #     # redirect_to "/rooms/#{@reservation.room.id}/show"
  #     redirect_to "/reservations/#{@reservation.id}/confirmation"
  #     # flash[:alert] = "チェックイン日時は明日以降で選択してください" if @reservation.start_date < Date.today + 1
  #     # flash[:alert] = "チェックアウト日時はチェックイン日時以降で選択してください" if @reservation.end_date < @reservation.start_date
  #   end
  # end
#####################################################################

  def show
    @reservation = Reservation.find(params[:id])
  end

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
    params.permit(:user_id, :room_id, :start_date, :end_date, :people_number, :total_price, :price)
  end

end
