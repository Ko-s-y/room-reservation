class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :passer

    def info
    end

    def show
    end

    def new
      @user = User.new(current_user_params)
    end

    def update
      @user = current_user
      if @user.update(current_user_params)
        flash[:notice] = "保存しました"
      else
        flash[:alert] = "更新できません"
      end
      render "info"
    end

    private

    def passer
      @user = current_user
    end

    def current_user_params
      params.require(:user).permit(:name, :email, :password, :avatar, :introduction)
    end

  end
