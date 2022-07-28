class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  # 投稿のみ
  def search_result
    @word = params[:word]
    # フォームが空だった時検索した時のページに
    if @word.blank?
      flash[:notice] = "検索フォームが空です。"
      redirect_back(fallback_location: root_path)
    else
      # 退会者を弾いて、部分一致のみ
      @posts = Post.narrow_down.looks("partial_match", params[:word]).page(params[:page]).per(10)
    end
  end
end
