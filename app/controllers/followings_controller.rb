class FollowingsController < ApplicationController
    def create 
        user = User.find(params[:id])
        follower = current_user.followings.build(followed_id: user.id)

        if follower.save 
            flash[:notice] = "You started to follow #{user.full_name.capitalize}."
            redirect_to root_path
        else 
            flash[:alert] = "Error trying to follow #{user.full_name.capitalize}."
            redirect_to root_path
        end
    end

    def destroy
        user = User.find(params[:id])
        follower = current_user.followings.find_by(followed_id: user.id)

        if follower.destroy
            flash[:notice] = "You successfully unfollowed #{user.full_name.capitalize}."
            redirect_to root_path
        else
            flash[:alert] = "Error trying to unfollowed #{user.full_name.capitalize}."
            redirect_to root_path
        end
    end
end
