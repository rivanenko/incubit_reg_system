class UsersController < ApplicationController
  before_action :find_user, only: [:update, :edit, :show]
  before_action :must_login, only: [:update, :edit, :show]

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(create_params)
    if @user.save
      UserMailer.welcome(@user).deliver
      cookies[:auth_token] = @user.token
      redirect_to login_path
    else
      render :new
    end
  end

  def update
    if @user.update_attributes(update_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def create_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def update_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end

  def find_user
    @user ||= User.find(params[:id])
  end
end
