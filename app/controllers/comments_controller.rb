class CommentsController < ApplicationController
  def create
    @board = Board.find(params[:board_id])
    @comment = current_user.comments.build(comment_params)
    @comment.board_id = @board.id
    @comment.save
  end

  def destroy
    @comment = current_user.comments.find(params[:comment_id])
    @comment.destroy!
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :board_id, :user_id)
  end
end
