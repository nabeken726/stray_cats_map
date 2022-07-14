class Admin::GenresController < ApplicationController
  # アクションが動く前にset_genreメソッドを実行
  before_action :authenticate_admin!
  before_action :set_genre, only: [:edit, :update, :destroy]

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:notice] = "作成しました。"
      redirect_to admin_genres_path
    else
      @genres = Genre.all
      flash[:alert] = "更新に失敗しました。"
      render "index"
    end
  end

  def edit
  end

  def update
    if @genre.update(genre_params)
      flash[:notice] = "更新しました。"
      redirect_to admin_genres_path
    else
      render "edit"
    end
  end

  def destroy
    @genre.destroy
    flash[:alert] = "削除しました。"
    redirect_to admin_genres_path
  end

  private

  def set_genre
    @genre = Genre.find(params[:id])
  end

  def genre_params
    params.require(:genre).permit(:genre)
  end
end
