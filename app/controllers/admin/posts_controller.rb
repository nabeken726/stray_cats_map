class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  # 管理者権限で使用する場合
  def map
    @posts = Post.all
  end

  def index
    @posts = Post.all.page(params[:page]).per(10)
  end

  def show
    # 削除したページに戻らないように
    @post = Post.find_by(id: params[:id])
    unless @post
      redirect_to admin_posts_path
      return
    end
    # コメント用
    @comment = Comment.new
    @comments = @post.comments
  end

  def edit
    @post = Post.find(params[:id])
  end


  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:alert] = "投稿を削除しました。"
    redirect_to admin_posts_path
  end
end

  # もし管理者が更新に使う場合
  # def update
  #   @post = Post.find(params[:id])
  #   if @post.update(post_params)
  #     redirect_to admin_post_path
  #   else
  #     render "edit"
  #   end
  # end