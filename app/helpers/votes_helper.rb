module VotesHelper
    def render_votting_btn(opinion)
        condition = Vote.where(user_id: current_user.id, opinion_id: opinion.id).empty?
        if condition 
            link_to("<div class='voting-btn'><span class='count-badge'>#{opinion.votes.count}</span>Upvote</div>".html_safe, root_path)
        else
            link_to("<div class='votting-btn downvote'><span class='count-badge'>#{opinion.votes.count}</span>Downvote</div>".html_safe, roo_path)
        end
    end
end
