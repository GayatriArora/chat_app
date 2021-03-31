class SessionsController < ApplicationController
  before_action :logged_in_redirect, only: [:new, :create]

  def new
  end

def create
  user = User.find_by(username: params[:session][:username])
  if user && user.authenticate(params[:session][:password])
    session[:user_id] = user.id
    flash[:success] = "You have successfully logged in"
    redirect_to root_path
  else
    flash.now[:error] = "There was something wrong with the credentials"
    render 'new'
#regular flash has a turn around of 1 request response cycle SInce we render new form and we want it to show on same thsi on
  end 
end

def destroy
  session[:user_id] = nil
  flash[:success] = "You have succesfully logged out"
  redirect_to login_path
end

private
def logged_in_redirect
  if logged_in?
    flash[:error] = "You are already logged in"
    redirect_to root_path
  end  
end


end

# success and error here are classes of semantic ui
