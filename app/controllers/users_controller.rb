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
      flash[:success] = "Congratulations! Your account has been created."
      redirect_to @user
    else 
      flash[:danger] = @user.errors.full_messages
      redirect_to users_new_path
    end
  end

  private 

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
