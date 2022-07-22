class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  # 投稿のみ
  def search_result
    @range = params[:range]
    @word = params[:word]
    @posts = Post.looks(params[:search], params[:word]).page(params[:page]).per(10)
  end
end
