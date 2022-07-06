class Public::PostsController < ApplicationController

  def index
    @post = Post.all
    # @genres = Genre.all
  end

  def show
    @post = Post.find(params[:id])
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
    # @post.genre_id = params[:post][:genre_id]
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

  private

  def post_params
    params.require(:post).permit(:title,:introduction,:image)
  end


end