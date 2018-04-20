class User < ActiveRecord::Base
    
    include EmailValidatable
    require 'bcrypt'

    before_create :set_confirmation_token

    validates_presence_of   :first_name, :message => 'Merci d\'entrer votre prénom.'
    validates_presence_of   :last_name, :message => 'Merci d\'entrer votre nom.'
    validates_presence_of   :email, :message => 'Merci d\'entrer un email.'
    validates_presence_of   :password, :message => 'Merci de renseigner un mot de passe.'
    #validates_presence_of   :password_confirmation, :message => 'Veuillez entrer à nouveau votre mot de passe.'
    validates_presence_of   :phone_number, :message => 'Merci d\'entrer un numéro de téléphone.'
    validates_presence_of   :biography, :message => 'Merci d\'entrer une brève biographie.'

    validates :email, email: true

    validates_uniqueness_of :email, :message => 'Cet email est déja utilisé'
    validates_uniqueness_of :phone_number, :message => 'Ce numéro est déja utilisé'

    validates :bio, length: { minimum: 8,
    too_short: "Le mot de passe doit contenir au moins 8 caractères" }

    #validates_confirmation_of :password, message: 'La confirmation de mot de passe ne correspond pas'

    # Bccrypt password methods
    def password
        @password ||= Password.new(password_hash)
    end

    def password=(new_password)
        @password = Password.create(new_password)
        self.password_hash = @password
    end

    # User methods

    def accept!
        self.accepted = true
        self.expired = false
    end

    def cancel_expire

    end

    def validate_email
        self.is_verified = true
        self.validation_date = Time.now
        self.confirm_token = nil
    end

    def set_confirmation_token
        if self.confirm_token.blank?
            self.confirm_token = SecureRandom.urlsafe_base64.to_s
        end
    end

    # Users methods

    def self.list 
        puts "-----------"

        User.all.each do |user|

            if !user.is_verified
                status = "En attente de validation"
            elsif user.accepted
                status = "Accepté"
            elsif user.expired
                status = "Non renouvellé"
            else
                status = "Dans la liste d'attente"
            end
                    
            puts user.first_name + " " + user.last_name + ": " + user.email + " - " + status
        end

        puts "Fin de la liste"
    end

    def self.unconfirmed 
        User.where(is_verified: false).each do |user|
            puts user.first_name + " " + user.last_name + ": " + user.email
        end
        puts 'Fin de la liste'
    end

    def self.confirmed
        User.where(is_verified: true).each do |user|
            puts user.first_name + " " + user.last_name + ": " + user.email
        end
        puts 'Fin de la liste'
    end

    def self.accepted
        User.where(accepted: true).each do |user|
            puts user.first_name + " " + user.last_name + ": " + user.email
        end
        puts 'Fin de la liste'
    end

    def self.expired
        User.where(expired: true).each do |user|
            puts user.first_name + " " + user.last_name + ": " + user.email
        end
        puts 'Fin de la liste'
    end
end