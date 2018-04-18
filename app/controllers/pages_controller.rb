class PagesController < ApplicationController

    def home
        @users_number = User.where(is_verified: true)

        if session[:user_id]
            redirect_to '/pages/show'
        end
    end

    def show
        @users_number = User.where(is_verified: true)

        if session[:user_id]
            @current_user = User.find(session[:user_id])
        end
    end

    def create
        @user = User.new
        @user.first_name = params[:first_name]
        @user.last_name = params[:last_name]
        @user.email = params[:email]
        @user.password = params[:password]
        @user.phone_number = params[:phone_number]
        @user.biography = params[:biography]
        @user.is_verified = false
        
        if @user.save
            UserMailer.welcome_email(@user).deliver!
            session[:user_id] = @user.id
            redirect_to '/pages/show'
        else
            render 'create'
        end
    end

    def login
        @current_user = User.where(email: params[:email], password: params[:password]).first
        if @current_user
            session[:user_id] = @current_user.id
            flash[:info] = "Content de vous voir #{@current_user.first_name} !"
            redirect_to "/pages/show"
        else
            flash[:info] = "Erreur d'adresse email ou de mot de passe"
            redirect_to root_path
        end
    end

    def disconnect
        session[:user_id] = nil
        redirect_to root_path
    end
end
