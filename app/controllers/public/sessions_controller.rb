# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
 # ゲストログイン用
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to public_show_path, notice: 'ゲストユーザーでログインしました。'
  end

  protected

  # Userの論理削除のための記述。退会後は、同じアカウントでは利用できない。
  def reject_user
    @user = User.find_by(name: params[:user][:name])
    if @user
      if @user.valid_password?(params[:user][:password]) && (@user.is_deleted == false)
        flash[:notice] = "退会済みです。"
        redirect_to new_user_registration
      else
        flash[:notice] = "項目を入力してください"
      end
    end
  end


  # Userログイン後の遷移先
  def after_sign_in_path_for(resource)
    root_path
  end

  # Userログアウト後の遷移先
  def after_sign_out_path_for(resource)
    root_path
  end
end
