class UsersController < ApplicationController
  def show

  end

  def update
    @user = User.find(params[:id])
    puts "password",  @user.password
    if @user.update user_params
      @user = User.find(params[:id])
      session[:state] = @user.state
      session[:firstname] = @user.firstname  
      session[:email] = @user.firstname
      session[:location] = @user.firstname
      redirect_to "/events"
    else
      flash[:errors] = @user.errors.full_messages     
      redirect_to "/user/#{@user.id}"
    end
  end

  private
  def user_params
    params.require(:user).permit(:firstname, :lastname, :location, :state, :email, :password, :password_confirmation)
  end

end
