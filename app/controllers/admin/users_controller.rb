class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: [:show,:edit,:update]

  def index
    # ページネーション追加
    @users = User.all.page(params[:page]).per(10)
  end

  def show
  end

  def edit
  end

  def update
    @user.update(user_params)
    flash[:notice] = "更新しました。"
    redirect_to admin_user_path(@user.id)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :is_deleted)
  end

  def set_user
     @user = User.find(params[:id])
  end
end
