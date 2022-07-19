class Public::GenresController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = current_user
    @posts = Post.where(genre_id: params[:genre]).page(params[:page]).per(10)
    @genres = Genre.all
  end
end
