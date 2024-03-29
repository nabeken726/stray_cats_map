class Public::UsersController < ApplicationController
  # User関連はUserのみにするように
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]
  before_action :set_user, only: [:show,:edit,:update]

  def index
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "更新しました。"
      redirect_to public_show_path
    else
      flash[:alert] = "更新に失敗しました。"
      render "edit"
    end
  end

  # 退会処理用の記述
  def withdrawal
    @user = User.find(params[:id])
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました。"
    redirect_to root_path
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :image)
  end

  # ログインしているユーザーがguestuserだったらeditさせない
  def ensure_guest_user
    if current_user.name == "guestuser"
      redirect_to public_show_path, notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end
  
  def set_user
    @user = current_user
  end

end
