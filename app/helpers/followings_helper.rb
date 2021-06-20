module FollowingsHelper
    def render_following_btn(follower)
        condition =  current_user.following?(follower)
        if condition 
            link_to("<div class='following-btn unfollow'><i class='bi bi-x'></i></div>".html_safe, following_path(follower), method: :delete)
        else
            link_to("<div class='following-btn'><i class='bi bi-plus'></i></div>".html_safe, followings_path(:id => follower.id), method: :post)
        end
    end
end
