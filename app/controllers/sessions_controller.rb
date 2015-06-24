class SessionsController < ApplicationController
  
  def new
    redirect_to home_path if logged_in?    
  end

  def create
    user = User.find_by(:email_address => params[:email_address])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "You have successfully logged in!"
      redirect_to home_path
    else
      flash[:error] = "There was a problem with your log in"
      render 'sessions/new'
    end
  end
  
  def destroy
    session[:user_id] = nil   
    flash[:notice] = "You have logged out!"
    redirect_to root_path
  end
end
