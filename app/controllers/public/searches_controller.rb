class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  # 投稿のみ
  def search_result
    @word = params[:word]
    # 退会者を弾いて、部分一致のみ
    @posts = Post.narrow_down.looks("partial_match", params[:word]).page(params[:page]).per(10)
  end
end
