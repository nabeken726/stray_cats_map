class Public::GenresController < ApplicationController
  def index
    @user = current_user
    @posts = Post.where(genre_id: params[:genre])
    @genres = Genre.all
  end
end
