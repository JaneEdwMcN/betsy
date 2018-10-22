class ApplicationController < ActionController::Base
  before_action :current_user
  before_action :find_user
  before_action :build_cart
  before_action :all_users
  before_action :all_categories

  helper_method :logged_in?
  helper_method :current_user

  private
  def build_cart
    session[:cart] = Array.new if !session[:cart]
  end

  def logged_in?
    current_user.present?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def find_user
    @user = User.find_by(id: params[:id])
  end

  def all_users
    @users = User.all
  end

  def all_categories
    @categories = Category.all
  end
end
