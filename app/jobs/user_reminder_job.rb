class UserReminderJob < ApplicationJob
  queue_as :default

  def perform(user)
    if !user.accepted
        UserMailer.welcome_email(user).deliver!
    end
  end
end
