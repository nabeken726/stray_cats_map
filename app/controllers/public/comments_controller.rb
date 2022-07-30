class Public::CommentsController < ApplicationController
  # 管理者が削除できるように
  before_action :authenticate_all_user,only: [:destroy]
  before_action :authenticate_user!,only: [:create]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    # flash.now[:notice] = 'コメントを投稿しました'
  end

  def destroy
    Comment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    # flash.now[:alert] = '投稿を削除しました'
    @post = Post.find(params[:post_id])
    @comment = @post.comments
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
