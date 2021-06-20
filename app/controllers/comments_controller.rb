class CommentsController < ApplicationController
  before_action :authenticate_user

  def create
    opinion = Opinion.find(comment_params[:opinion_id])
    comment = opinion.comments.build(user_id: current_user.id, content: comment_params[:content])
    if comment.save
      flash[:notice] = 'Welcome to Book Reviewer ✨'
    else
      flash[:alert] = "Oooh, The comment couldin't be saved. 😥 Comment content #{comment.errors[:content][0]}"
    end
    redirect_to request.referrer
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :opinion_id)
  end
end
