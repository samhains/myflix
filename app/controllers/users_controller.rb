class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "You are now logged in"
      redirect_to home_path
    else
      render 'users/new'
    end
  end
  
  private

  def user_params
    params.require(:user).permit([:name,:password,:email_address])
  end
  
end
