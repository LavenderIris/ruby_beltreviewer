class SessionsController < ApplicationController

  skip_before_action :require_login, only: [:index, :create]

  def index
    
  
  end

  def create
    if params[:user][:password] != params[:user][:password_confirm]
      flash[:errors_password] = "password doesn't match"
    end

    user = User.new(user_params)
    if user.save 
      flash[:success] = "You have successfully registered. Please login."
    else 
      flash[:errors]=user.errors.full_messages
    end
    redirect_to ''
  end

  def login
    user = User.find_by_email(params[:email]).try(:authenticate, params[:password])
    if user
      session[:id] = user.id
      session[:firstname]= user.firstname
      session[:lastname] = user.lastname
      session[:state] = user.state
      redirect_to '/events'
    else 
      flash[:login_error]= "user not found and/or password doesn't match"
      redirect_to ''
    end
  end

  def destroy
    reset_session
    redirect_to ""
  end

  private 
  def user_params
    params.require(:user).permit(:firstname, :lastname, :email, :location, :state, :password)
  end
end
