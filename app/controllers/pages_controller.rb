class PagesController < ApplicationController

    def home
        if session[:user_id]
            redirect_to '/pages/show'
        end
    end

    def create
        if session[:user_id]
            @current_user = User.find(session[:user_id])
        end
    end

    def show
        if session[:user_id]
            @current_user = User.find(session[:user_id])
        end
    end

    def add_user
        user = User.new
        user.first_name = params[:first_name]
        user.last_name = params[:last_name]
        user.email = params[:email]
        user.password = params[:password]
        user.phone_number = params[:phone_number]
        user.biography = params[:biography]
        user.is_verified = false
        
        if user.save
            session[:user_id] = user.id
            redirect_to '/pages/show'
        else
            flash[:info] = user.errors.first
            redirect_to "/pages/create"
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
