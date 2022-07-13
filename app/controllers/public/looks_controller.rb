class Public::LooksController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    look = current_user.looks.new(post_id: @post.id)
    look.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    look = current_user.looks.find_by(post_id: @post.id)
    look.destroy
  end
end
