class UsersController < ApplicationController
    before_action :authenticate_user
    
    def new 
        @user = User.new
    end

    def create 
        @user = User.find_by(username: user_params[:username])

        if @user 
            flash.now[:alert] = "User already exit, #{helpers.link_to("Login instead", sessions_path(:username => @user.username), method: :post)}.".html_safe
            render 'new'
        else
            @user = User.new(user_params)
            if (@user.save)
                 redirect_to sessions_path(:username => @user.username)
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
end
