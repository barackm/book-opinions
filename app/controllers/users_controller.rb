class UsersController < ApplicationController    
    before_action :check_logged_in_user, only: [:create, :new]

    def new 
        @user = User.new
    end

    def show 
        @user = User.find(params[:id])
        @people_to_follow = current_user.people_to_follow
        @opinions = current_user.timeline_opinions
        @opinion = Opinion.new
    end

    def create 
        @user = User.find_by(username: user_params[:username])

        if @user 
            flash.now[:alert] = "User already exit, #{helpers.link_to("Login instead", sessions_path(:username => @user.username), method: :post)}.".html_safe
            render 'new'
        else
            @user = User.new(user_params)
            if (@user.save)
                session[:username] = @user.username
                flash[:notice] = "Welcome to Book Reviewer ✨"
                redirect_to root_path
            else
                flash.now[:alert] = "An Unexpected error accured. 😥"
                render "new"
            end
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :full_name)
    end

    def check_logged_in_user
          signed_in? and redirect_to root_path
    end
end
