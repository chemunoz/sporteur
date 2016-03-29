class CommentsController < ApplicationController
  def create
    @match=Match.find params[:match_id]
    @comment=@match.comments.new(comment_params)

    if @comment.save
      redirect_to match_path(@match)
    else
      render 'new'
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:message)
    #Nos aseguramos que haya una key "entry" y si la hay esas keys de permit
  end
end
