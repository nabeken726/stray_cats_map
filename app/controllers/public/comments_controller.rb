class Public::CommentsController < ApplicationController

  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      # コメント送信後は、一つ前のページへリダイレクトさせる。
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
  @comment = @post.comments.find(params[:id])
  @comment.destroy
  end

  private
  def comment_params
    #formにてpost_idパラメータを送信して、コメントへpost_idを格納するようにする必要がある。
    params.require(:comment).permit(:comment, :post_id)
  end

end
