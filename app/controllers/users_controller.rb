class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id]) 
  end

  def create 
    @user = User.new(user_params)
    if @user.save
      reset_session
      log_in @user
      flash.now[:success] = "Congratulations! Your account has been created."
      redirect_to @user
    else 
      flash.now[:danger] = @user.errors.full_messages
      render 'new'
    end
  end

  private 

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
