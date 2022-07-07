class Public::LooksController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    comment = current_user.comment.new(post_id: post.id)
    comment.save
    redirect_to public_post_path(post)
  end

  def destroy
    post = Post.find(params[:post_id])
    comment = current_user.comment.new(post_id: post.id)
    comment.destroy
    redirect_to public_post_path(post)
  end

end
