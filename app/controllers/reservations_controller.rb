class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :passer

  def index
    @reservations = Reservation.all
    @rese_rooms = Reservation.count
  end

  def new
    @reservation = current_user.reservations.build  #1対多の為、build
  end

  def create
    #binding.pry
    @reservation = current_user.reservations.build(reservation_params)
    if @reservation.save
      flash[:notice] = "お部屋の予約が完了しました"
    else
      #binding.pry
      flash[:alert] = "お部屋の予約に失敗しました"
    end
    redirect_to "/rooms/registered"
  end

  def destroy
  end

  private

  def passer
    @user = current_user
    @room = Room.find_by(params[:id])
    @reservation = Reservation.find_by(params[:id])
  end

  def reservation_params
    params.permit(:user_id, :room_id, :start_date, :end_date, :people_number)
  end

end
