class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  private

  def must_login
    unless current_user
      flash[:danger] = "Please login!"
      redirect_to login_path
    end
  end
end
