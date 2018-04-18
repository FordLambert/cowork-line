class User < ActiveRecord::Base
    validates_presence_of   :first_name, :message => 'Merci d\'entrer votre prénom.'
    validates_presence_of   :last_name, :message => 'Merci d\'entrer votre nom.'
    validates_presence_of   :email, :message => 'Merci d\'entrer un email.'
    validates_presence_of   :password, :message => 'Merci de renseigner un mot de passe.'
    validates_presence_of   :phone_number, :message => 'Merci d\'entrer un numéro de téléphone.'
    validates_presence_of   :biography, :message => 'Merci d\'entrer une brève biographie.'

    validates_uniqueness_of :email, :message => 'Cet email est déja utilisé'
    validates_uniqueness_of :phone_number, :message => 'Ce numéro est déja utilisé'

    
end