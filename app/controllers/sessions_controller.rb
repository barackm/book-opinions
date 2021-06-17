class SessionsController < ApplicationController
    before_action :check_logged_in_user, only: [:create, :new]

    def new 
        @user = User.new
    end

    def create 
        
        @user = User.find_by(username: params[:username])
        # puts "----------#{params}--------"
        if @user
            session[:username] = @user.username
            flash[:notice] = "Welcome to Book Reviewer ✨" 
            redirect_to root_path
        else
            flash.now[:alert] = "Invalid username. 😥"
            render 'new'
        end
    end

    def destroy
        puts "----- wanted to delete a user"
        session[:username] = nil
        flash[:notice] = "You have successfully signed out ✨" 
        redirect_to new_session_path
    end

    private 
    
    def check_logged_in_user
          signed_in? and redirect_to root_path
    end
end
