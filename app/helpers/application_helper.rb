module ApplicationHelper
  # ユーザーステータス記述
  def user_status(user)
    user.is_deleted ? "退会" : "有効"
  end
end
