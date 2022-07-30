module ApplicationHelper
  # ユーザーステータス記述 admin showで使用 ifでの書き方と
  def user_status(user)
    user.is_deleted ? "退会" : "有効"
  end
end
