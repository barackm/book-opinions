class UsersController < ApplicationController    
    before_action :check_logged_in_user, only: [:create, :new] 
    before_action :check_current_user, only: [:edit, :update, :destroy]

    def new 
        @user = User.new
    end

    def show 
        @user = User.find(params[:id])
        @people_to_follow = current_user.people_to_follow
        @opinions = current_user.timeline_opinions
        @opinion = Opinion.new
        @comment = Comment.new
    end

    def create 
        
        @user = User.find_by(username: user_params[:username].delete(" ").downcase.to_s)
        if @user 
            flash.now[:alert] = "User already exit, #{helpers.link_to("Login instead", sessions_path(:user => {username: @user.username}), method: :post)}.".html_safe
            render 'new'
        else
            @user = User.new(user_params)
            if (@user.save)
                session[:username] = @user.username
                flash[:notice] = "Hi #{@user.full_name.split(" ")[0].capitalize}, Welcome to Book Reviewer ✨"
                redirect_to root_path
            else
                flash.now[:alert] = "An Unexpected error accured. 😥"
                render "new"
            end
        end
    end

    def edit 
        @user = current_user
    end

    def update 
        @user = User.find(current_user.id);
        if @user.update(update_params)
            session[:username] = @user.username
            flash[:notice] = "Profile updated successfully ✨"
            redirect_to root_path
        else
            flash.now[:alert] = "Error while trying to update your account. 😥"
            render "edit"
        end
    end

    def destroy
        @user = User.find(current_user.id);
        @user.destroy 

        flash[:notice] = "Account canceled successfully.✨"
        redirect_to root_path
    end

    private

    def user_params
        params.require(:user).permit(:username, :full_name)
    end

    def update_params
        params.require(:user).permit(:username, :full_name, :photo, :cover_image)
    end

    def check_logged_in_user
          signed_in? and redirect_to root_path
    end

    def check_current_user
        user = User.where(id: params[:id])
        redirect_to root_path if user[0]&.id != current_user.id
    end
end
