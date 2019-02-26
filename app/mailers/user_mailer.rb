class UserMailer < ApplicationMailer
  def welcome(user)
    @user = user

    mail(to: @user.email, subject: "Welcome to Incubit, #{@user.name}")
  end

  def reset_password(user)
    @user = user
    mail(to: @user.email, subject: "Reset password")
  end
end
