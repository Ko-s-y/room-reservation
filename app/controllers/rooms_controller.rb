class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :passer, except: [:show]

  #before_action :evaluate, only: [:show]
  #after_action :evaluate, only: [:show]

  def index
    # @rooms = Room.all
  end

  def registered
    @rooms = current_user.rooms  # ログイン中ユーザーが登録したroom一覧ページのみ取得
    @regi_rooms = Room.count
    @user = current_user
  end

  def new
    @room = current_user.rooms.build  #1対多の為、build
  end

  def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      flash[:notice] = "お部屋を登録しました"
      redirect_to "/rooms/registered"
    else
      flash.now[:alert] = "お部屋の登録に失敗しました"
      render "rooms/show"
    end
  end

  def show
    @room = Room.find(params[:id])
    @reservation = Reservation.new
  end

  def destroy
    @room.destroy
    flash[:notice] = "ルームを削除しました"
    redirect_to "/rooms/registered"
  end

  private

  def passer
    @room = Room.find_by(params[:id])
  end

  def evaluate
    # check_in = @reservation.start_date# d.strftime('%d')
    # check_out = @reservation.end_date# .strftime('%d')
    # @night_count = @check_out.to_i - @check_in.to_i
    # @day_count = @night_count + 1
    # @total_price = @room.price * @night_count
  end

  def room_params
    params.require(:room).permit(:room_name, :description, :price, :address, :avatar)
  end

end
