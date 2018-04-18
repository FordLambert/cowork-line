class PagesController < ApplicationController

    def home
        @verified_users = User.where(is_verified: true)

        if @verified_users.length > 1
            @plural = true
        else
            @plural = false
        end

        if session[:user_id]
            redirect_to '/pages/show'
        end
    end

    def show
        @verified_users = User.where(is_verified: true)

        if @verified_users.length > 1
            @plural = true
        else
            @plural = false
        end


        if session[:user_id]
            @current_user = User.find(session[:user_id])
            sorted_users = @verified_users.sort_by &:validation_date
            @position = sorted_users.find_index(@current_user) + 1
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
            #UserMailer.welcome_email(@user).deliver!
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
