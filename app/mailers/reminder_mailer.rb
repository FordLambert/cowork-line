class ReminderMailer < ApplicationMailer
  default from: "ford.nilap@gmail.com"

  def sample_email(user)
    @user = user
    mail(to: @user.email, subject: 'Toujours sur Cowork ?')
  end
end
