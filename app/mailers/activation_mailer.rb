class ActivationMailer < ApplicationMailer
  default from: 'Music App <admin@musicapp.com>'

  def activation_email(user)
    @user = user
    @url = activate_users_url(activation_token: user.activation_token)
    mail(to: user.email, subject: 'Music App: Please activate your account')
  end
end
