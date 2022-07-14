class Public::PostsController < ApplicationController
  # ログインしていないとshow,create 使用不可
  before_action :authenticate_user!, only: [:show, :create, :my_index]
  # 自分の投稿
  def my_index
    @user = current_user
    @posts = Post.where(user_id: current_user.id).page(params[:page]).per(10)
  end

  def index
    @genres = Genre.all
    # 退会しているuserの投稿は取得しない
    @posts = Post.narrow_down.page(params[:page]).per(10)
  end

  def show
    @post = Post.find(params[:id])
    # コメント用
    @comment = Comment.new
    @comments = @post.comments
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "更新しました。"
      redirect_to public_post_path(@post)
    else
      render "edit"
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.genre_id = params[:post][:genre_id]
    if @post.save
      flash[:notice] = "投稿しました。"
      redirect_to public_post_path(@post)
    else
      flash[:alert] = "投稿できませんでした。"
      render "new"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:alert] = "投稿を削除しました。"
    redirect_to public_posts_path
  end

  def map
    @posts = Post.all
  end

  private

  def post_params
    params.require(:post).permit(:title, :introduction, :image, :comment, :genre_id, :latitude, :longitude)
  end
end
