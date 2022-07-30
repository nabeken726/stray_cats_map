class ApplicationController < ActionController::Base

  def authenticate_all_user
    user_signed_in? || admin_signed_in?
  end
end
