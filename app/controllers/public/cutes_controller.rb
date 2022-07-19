class Public::CutesController < ApplicationController
  before_action :authenticate_user!
  def create
    @post = Post.find(params[:post_id])
    cute = current_user.cutes.new(post_id: @post.id)
    cute.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    cute = current_user.cutes.find_by(post_id: @post.id)
    cute.destroy
  end
end
