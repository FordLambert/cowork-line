class User < ActiveRecord::Base

    before_create :set_confirmation_token

    validates_presence_of   :first_name, :message => 'Merci d\'entrer votre prénom.'
    validates_presence_of   :last_name, :message => 'Merci d\'entrer votre nom.'
    validates_presence_of   :email, :message => 'Merci d\'entrer un email.'
    validates_presence_of   :password, :message => 'Merci de renseigner un mot de passe.'
    validates_presence_of   :password, :message => 'Veuillez entrer à nouveau votre mot de passe.'
    validates_presence_of   :phone_number, :message => 'Merci d\'entrer un numéro de téléphone.'
    validates_presence_of   :biography, :message => 'Merci d\'entrer une brève biographie.'

    validates_uniqueness_of :email, :message => 'Cet email est déja utilisé'
    validates_uniqueness_of :phone_number, :message => 'Ce numéro est déja utilisé'

    validates :password, confirmation: true

    private
    
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
end