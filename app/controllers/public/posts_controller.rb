class Public::PostsController < ApplicationController

  def index
    @post = Post.all
    # @genres = Genre.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(product_params)
    @post.user_id = current_user.id
    # @post.genre_id = params[:post][:genre_id]
      if @post.save
        redirect_to public_posts_path(@post)
      else
        render :new
      end
  end

  private

  def post_params
    params.require(:product).permit(:title,:introduction,:post_image_url)
  end


end
