class ApplicationController < ActionController::Base
    helper_method :current_user

    def current_user
        user ||= User.find_by(username: session[:username]) if session[:username]  
    end

    def authenticate_user
        return if signed_in?
            flash[:alert] = 'You need to Sign in or Sign up first'
            redirect_to new_session_path
    end

    def signed_in?
       !current_user.nil?
    end
end
