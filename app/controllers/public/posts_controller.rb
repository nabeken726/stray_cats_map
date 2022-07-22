class Public::PostsController < ApplicationController
  # ログインしていないとshow,create 使用不可
  before_action :authenticate_user!, except: [:index, :map]
  # 自分の投稿
  def my_index
    @user = current_user
    @posts = Post.where(user_id: current_user.id).page(params[:page]).per(10)
  end

  def index
    @user = current_user
    @genres = Genre.all
    # 退会しているuserの投稿は取得しない
    @posts = Post.narrow_down.page(params[:page]).per(10)
  end

  def show
    # 削除したページに戻らないように
    @post = Post.find_by(id: params[:id])
    if @post == nil
      redirect_to public_posts_path
      return
    end
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

  # かわいい、見た機能の投稿一覧
  def cutes
    @user = User.find(params[:id])
    cutes = Cute.where(user_id: @user.id).pluck(:post_id)
    @cute_posts = Post.find(cutes)
  end

  def looks
    @user = User.find(params[:id])
    looks = Look.where(user_id: @user.id).pluck(:post_id)
    @look_posts = Post.find(looks)
  end


  private

  def post_params
    params.require(:post).permit(:title, :introduction, :image, :comment, :genre_id, :latitude, :longitude)
  end
end
