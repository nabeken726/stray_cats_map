class Public::UsersController < ApplicationController
  # User関連はUserのみにするように
  before_action :authenticate_user!
  def index
    @users = User.all
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to public_show_path(@user)
    else
      render "edit"
    end
  end

  private
  def user_params
  params.require(:user).permit(:name,:email,:image)
  end

end