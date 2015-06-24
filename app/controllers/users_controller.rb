class UsersController < ApplicationController

  def new
    redirect_to home_path if logged_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path
    else
      render 'users/new'
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:name,:password,:email_address)
  end
  
end
