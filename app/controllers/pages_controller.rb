class PagesController < ApplicationController

    def home
        if session[:user_id]
            #session[:user_id] = nil
            redirect_to '/pages/show'
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
        user.save
        session[:user_id] = user.id
        redirect_to '/pages/show'
    end

    def login
        @current_user = User.where(email: params[:email], password: params[:password]).first
        if @current_user
            session[:user_id] = @current_user.id
            flash[:info] = "Content de vous voir #{@current_user.first_name} !"
            redirect_to "/pages/show"
        else
            flash[:info] = "Erreur de connection mon brave."
            redirect_to root_path
        end
    end

    def disconnect
        session[:user_id] = nil
        redirect_to root_path
    end
end
