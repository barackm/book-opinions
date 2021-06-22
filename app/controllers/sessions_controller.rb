class SessionsController < ApplicationController
  before_action :check_logged_in_user, only: %i[create new]

  def new
    @user = User.new
  end

  def create
    username = params[:user][:username].delete(' ').downcase

    @user = User.find_by(username: username)
    if @user
      session[:username] = @user.username
      flash[:notice] = "Hi #{@user.full_name.split[0].capitalize}, Welcome to Book Reviewer ✨"
      redirect_to root_path
    else
      flash[:alert] = 'Invalid username. 😥'
      redirect_to new_session_path
    end
  end

  def destroy
    session[:username] = nil
    flash[:notice] = 'You have successfully signed out ✨'
    redirect_to new_session_path
  end

  private

  def check_logged_in_user
    signed_in? and redirect_to root_path
  end
end
