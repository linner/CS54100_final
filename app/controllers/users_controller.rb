class UsersController < ApplicationController

  def index
    @users = User.where(:account_type => "user")
  end

  def show
    @user = User.find(params[:id])
    
    @submissions = @user.assignments.where(:submitted => true)
  end

  def new
    if current_user
      flash[:notice] = "Already logged in."
      redirect_to questionnaires_path
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      flash[:notice] = "Account created."
      redirect_to login_path
    else
      render "new"
    end
  end
end
