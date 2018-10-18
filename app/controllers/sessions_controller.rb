class SessionsController < ApplicationController
  def create
    # auth_hash = request.env['omniauth.auth']
    #
    # user = User.find_by(uid: auth_hash[:uid], provider: 'github') ||
    # User.create_from_github(auth_hash)

    user = User.find_by(username: params[:user][:name])

    if user.nil?
      user = User.create(name: params[:user][:name], email: params[:user][:email])

      if user.save
        session[:user_id] = user.id
        flash[:success] = "#{ user.name } Successfully logged in!"
        redirect_to root_path
      else
        flash[:warning] = "#{ user.name } Unable to log in!"
        redirect_to root_path
      end

    else
      session[:user_id] = user.id
      flash[:success] = "#{ user.name } Successfully logged in!"
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
