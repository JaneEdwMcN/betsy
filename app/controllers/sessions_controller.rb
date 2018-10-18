class SessionsController < ApplicationController
  def create
    auth_hash = request.env['omniauth.auth']

    user = User.find_by(uid: auth_hash[:uid], provider: 'github') ||
    User.create_from_github(auth_hash)

    if user
      flash[:result_text] = "Logged in as returning user #{user.name}"
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:error] = "Could not create new user account: #{user.errors.messages}"
      redirect_to root_path
    end
  end

  def new
    @user = User.new
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'Successfully logged out'
    redirect_back fallback_location: root_path
  end
end
