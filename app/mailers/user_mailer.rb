class UserMailer < ApplicationMailer
    default from: 'ford.lambert@gmail.com'
 
    def welcome_email(user)
        @user = user
        @url  = 'http://example.com/login'
        mail(to: @user.email, subject: 'Bienvenue sur Cowork-line')
    end
end
