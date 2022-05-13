class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :passer

    def info
    end

    def show
    end

    def update
      if @user.update(user_params)
        flash[:notice] = "アカウントが更新されました"
      else
        flash.now[:alert] = "更新に失敗しました"
      end
      render "info"
    end

    private

    def passer
      @user = current_user
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :avatar, :introduction)
    end

  end
