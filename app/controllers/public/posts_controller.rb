class Public::PostsController < ApplicationController
  # ログインしていないとshow,create 使用不可
  before_action :authenticate_user!, only: [:show, :create,:my_index]
  # 自分の投稿
  def my_index
  end

  def index
    @posts = Post.all
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
      redirect_to public_post_path
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
        redirect_to public_post_path(@post)
      else
        render :new
      end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to public_posts_path
  end

  def map
    @posts = Post.all
  end

  private

  def post_params
    params.require(:post).permit(:title,:introduction,:image,:comment,:genre_id,:latitude,:longitude)
  end


end