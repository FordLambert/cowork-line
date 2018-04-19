class ExpireUserJob < ApplicationJob
  queue_as :default

  def perform(user)
    if !user.accepted
        user.expired = true
    end
  end

  def return_concerned_user
    return user
  end
end
