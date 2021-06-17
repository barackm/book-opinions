class SessionsController < ApplicationController
    def new 
        @user = User.new
    end

    def create 
        @user = User.find_by(username: params[:username])
        if @user
            session[:username] = @user.username
            flash[:notice] = "Welcome to Book Reviewer ✨" 
            redirect_to root_path
        else
            flash.now[:alert] = "An Unexpected error accured. 😥"
            redirect_to new_session_path
        end
    end

    def destroy
        session[:username] = nil
    end
end
