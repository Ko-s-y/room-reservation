class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :passer

  def index  #ユーザー予約一覧
    @reservations = @user.reservations
    @reserve_counter = @reservations.count
  end

  def new  #rooms/showより新規予約
    @reservation = Reservation.new(reservation_params)
    @room = Room.find_by(id: @reservation.room_id)
    # if @user == @room.user
    #   flash[:alert] = "オーナーが自分のルームを予約することはできません。"
    #   redirect_to "/"
    # else
      flash.now[:alert] = "チェックイン日時は明日以降で選択してください" if @reservation.start_date < Date.today
      flash.now[:alert] = "チェックアウト日時はチェックイン日時以降で選択してください" if @reservation.end_date < @reservation.start_date
      render template: "rooms/show" if @reservation.invalid?
    # end
  end

  def create  #resevations/newの確認画面より予約作成
    # binding.pry
    @reservation = Reservation.new(reservation_params)
    # @reservation = current_user.reservations.build(reservation_params)
    @room = Room.find_by(id: @reservation.room_id)
    # binding.pry
    if @reservation.save
      # binding.pry
      flash[:notice] = "お部屋の予約が完了しました"
      redirect_to "/reservations/#{@reservation.id}/show"
    else
      flash.now[:alert] = "エラーが発生しました。最初からやり直してください"
      render "rooms/show"
    end
  end

  def show  #予約確認画面
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
