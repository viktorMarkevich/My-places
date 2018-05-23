class ConfirmationMailer < ApplicationMailer

  def send_confirmation_email(user, full_name, email)
    @user = user
    @full_name = full_name

    mail(to: email, subject: 'Confirm your registration')
  end
end
