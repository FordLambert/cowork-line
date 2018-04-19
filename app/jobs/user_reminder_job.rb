class UserReminderJob < ApplicationJob
  queue_as :default

  def perform(user)
    if !user.accepted
        #send an email to remind user
    end
  end
end
