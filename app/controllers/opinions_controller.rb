class OpinionsController < ApplicationController
  before_action :authenticate_user
  def index
    @people_to_follow = current_user.people_to_follow
    @opinions = current_user.timeline_opinions
    @opinion = Opinion.new
    @comment = Comment.new
  end

  def create
    user = current_user
    @opinion = user.opinions.build(opinion_params)
    if @opinion.save
      flash[:notice] = 'Opinion created successfully.'
    else
      flash[:alert] = "Sorry the opinion was not saved. Opinion content #{@opinion.errors[:text][0]}"
    end
    redirect_to request.referrer
  end

  private

  def opinion_params
    params.require(:opinion).permit(:text)
  end
end
