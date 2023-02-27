class CommentsController < ApplicationController
  def create
    @board = Board.find(params[:board_id])
    @comment = current_user.comments.build(comment_params)
    @comment.board_id = @board.id
    if @comment.save
      redirect_to(board_path(@comment.board), flash:{success: t('.success')})
    else
      #flash.now[:danger] = t('.fail')
      redirect_to(board_path(@comment.board), flash:{danger: t('.fail')})
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :board_id, :user_id)
  end
end
