class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @current_user ||= User.find_by_token!(cookies[:auth_token]) if cookies[:auth_token]
  end

  private

  def must_login
    unless current_user
      flash[:danger] = "Please login!"
      redirect_to login_path
    end
  end
end
