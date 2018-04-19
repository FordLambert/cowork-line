class UserMailer < ApplicationMailer
    default from: 'ford.nilap@gmail.com'
 
    def welcome_email(user)
        @user = user
        mail(to: @user.email, subject: 'Bienvenue sur Cowork-line')
    end
end
