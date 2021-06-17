class ApplicationController < ActionController::Base
    def current_user
       @user = User.find_by(username: session[:username])   
    end
    
    def authenticate_user
        return if current_user
        flash[:alert] = 'You need to Sign in or Sign up first'
        redirect_to new_session_path
    end
end
