module AdminMethods
  module Console

    def unconfirmed 
        User.where(is_verified: false).each do |user|
            puts user.first_name + " " + user.last_name + ": " + user.email
        end
        puts 'Fin de la liste'
    end

    def confirmed
        User.where(is_verified: false).each do |user|
            puts user.first_name + " " + user.last_name + ": " + user.email
        end
        puts 'Fin de la liste'
    end

    def accepted
        User.where(accepted: true).each do |user|
            puts user.first_name + " " + user.last_name + ": " + user.email
        end
        puts 'Fin de la liste'
    end

    def expired
        User.where(expired: true).each do |user|
            puts user.first_name + " " + user.last_name + ": " + user.email
        end
        puts 'Fin de la liste'
    end
    
  end
end