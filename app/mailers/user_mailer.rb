class UserMailer < ApplicationMailer
    default from: 'ford.lambert@gmail.com'
 
    def welcome_email(user)
        @user = user
        @url  = 'http://localhost:3000/pages/#{@user.id}'
        mail(to: @user.email, subject: 'Bienvenue sur Cowork-line')
    end
end
