class UsersController < ApplicationController
  before_action :find_user, only: [:show]

  def index
    @users = User.all
  end

  def show ;end


  def print_products
    @user.products
  end

   private

   def user_params
     return params.require(:user).permit(:name, :email)
   end
end
