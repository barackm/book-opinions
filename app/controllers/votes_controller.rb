class VotesController < ApplicationController
  before_action :authenticate_user

  def create
    opinion = Opinion.find(params[:opinion_id])
    vote = opinion.votes.build(user_id: current_user.id)

    if vote.save
      flash[:notice] = 'You upvoted successfully ✨'
    else
      flash[:alert] = 'Oooh, Sorry there was an error trying to upvote. 😥'
    end
    redirect_to request.referrer
  end

  def destroy
    opinion = Opinion.find(params[:opinion_id])
    vote = opinion.votes.where(user_id: current_user.id)

    if vote[0].destroy
      flash[:notice] = 'You downvoted successfully ✨'
    else
      flash[:alert] = 'Oooh, Sorry there was an error trying to downpvote. 😥'
    end
    redirect_to request.referrer
  end
end
