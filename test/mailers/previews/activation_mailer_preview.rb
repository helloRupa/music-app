# Preview all emails at http://localhost:3000/rails/mailers/activation_mailer
class ActivationMailerPreview < ActionMailer::Preview
  def activation_email
    ActivationMailer.with(user: User.first).activation_email(User.first)
  end
end
