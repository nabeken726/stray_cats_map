class Public::CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash.now[:notice] = 'コメントを投稿しました'
      render "public/comments/post_comments"
    else
      render "error"
    end
  end

  def destroy
    Comment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    flash.now[:alert] = '投稿を削除しました'
    @post = Post.find(params[:post_id])
    render "post_comments"
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
