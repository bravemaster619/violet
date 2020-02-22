class UsersMailer < ApplicationMailer
  def send_verification_code
    @user = params[:user]

    mail(to: @user.email, subject: 'Please verify your email')
  end
end