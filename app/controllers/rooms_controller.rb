class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :passer

  def index
  end

  def registered
    @rooms = current_user.rooms  # ログイン中ユーザーが登録したroom一覧ページのみ取得
  end

  def reserved  # reserveテーブル作ったら訂正
    @rooms = current_user.rooms
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
      flash[:alert] = "お部屋の登録に失敗しました"
      render "new"
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def passer
    @room = Room.find_by(params[:id])
  end

  def room_params
    params.require(:room).permit(:room_name, :description, :price, :address)
  end

end
