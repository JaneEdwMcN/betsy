class ApplicationController < ActionController::Base

  private
    def find_user
      @current_user = User.find_by(id: session[:user_id])
    end
end
