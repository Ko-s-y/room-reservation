class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :passer, except: [:show]

  def index
    @result_count = @rooms.count
  end

  def registered
    @rooms = @user.rooms  # ログイン中ユーザーが登録したroom一覧ページのみ取得
    @regi_rooms = @rooms.count
    @total_rooms = Room.count
  end

  def new
    @room = @user.rooms.build  #1対多の為、build
  end

  def create
    @room = @user.rooms.build(room_params)
    if @room.save
      flash[:notice] = "お部屋を登録しました"
      redirect_to "/rooms/registered"
    else
      flash.now[:alert] = "お部屋の登録に失敗しました"
      render "rooms/new"
    end
  end

  def show
    @room = Room.find(params[:id])
  end

  private

  def passer
    @user = current_user
    @room = Room.find_by(params[:id])
  end

  def room_params
    params.require(:room).permit(:room_name, :description, :price, :address, :avatar)
  end

end
