class OpinionsController < ApplicationController
    before_action :authenticate_user
    def index 
        puts "----------#{current_user.username}"

    end
end
