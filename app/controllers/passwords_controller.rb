class PasswordsController < ApplicationController
  before_action :find_user, only: [:edit, :update]

  def update
    if @user.reset_token_sent_at < User::TOKEN_EXPIRES_IN.ago
      redirect_to new_password_path, alert: "Token has expired"
    elsif @user.update_attributes(user_params)
      redirect_to root_url, notice: "Password has been reset!"
    else
      render :edit
    end
  end

  def create
    user = User.find_by_email(params[:email])
    if user
      UserMailer.reset_password(user).deliver if user.token_reset
      message = "Reset password email has been sent"
    else
      message = "Cannot find the user" 
    end
    redirect_to root_url, notice: message
  end

  private

  def find_user
    @user = User.find_by_reset_token!(params[:id])
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
