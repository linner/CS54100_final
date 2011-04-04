class SessionsController < ApplicationController
  
  #Already logged in?
  def new
    if current_user
      redirect_to questionnaires_path
    end
  end

  #Login
  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      flash[:notice] = "Successfully logged in."
      redirect_to questionnaires_path
    else
      flash[:alert] = "Invalid e-mail/password combination."
      render "new"
    end
  end

  #Logout
  def destroy
    session[:user_id] = nil
    redirect_to login_path, :notice => "Logged out."
  end
end
