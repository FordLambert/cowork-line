class PagesController < ApplicationController

    before_action :get_current_user, only: [:home, :show]

    def home
        @verified_users = User.where(is_verified: true)

        if @verified_users.length > 1
            @plural = true
        else
            @plural = false
        end

        if @current_user 
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

        if @current_user
            if @current_user.is_verified
                sorted_users = @verified_users.sort_by &:validation_date
                @position = sorted_users.find_index(@current_user) + 1
            end
        end
    end

    def create
        if @user
            @user.errors.clear
        end
    end

    def add_user
        @user = User.new
        @user.first_name = params[:first_name]
        @user.last_name = params[:last_name]
        @user.email = params[:email]
        @user.password = params[:password]
        @user.phone_number = params[:phone_number]
        @user.biography = params[:biography]
        @user.is_verified = false
        @user.accepted = false
        @user.expired = false
        
        if @user.save
            @user.set_confirmation_token
            UserMailer.welcome_email(@user).deliver!

            session[:user_id] = @user.id

            redirect_to '/pages/show'
        else
            render 'create'
        end
    end

    def resend_email
        @user = User.find(session[:user_id])
        UserMailer.welcome_email(@user).deliver!
    end

    def success
        if session[:user_id]
            @current_user = session[:user_id]
            render 'show'
        end
    end

    def confirm_email
        user = User.where(confirm_token: params[:token]).first
        if user
            user.validate_email
            user.save(validate: false)
            UserReminderJob.set(wait: 3.month).perform_later(user)
            ExpireUserJob.set(wait: 3.month + 1.week).perform_later(user)
            session[:user_id] = user.id
            redirect_to 'pages/show'
        else
            redirect_to root_url
        end
    end

    def confirm_user
        #I don't like the following loop at all but for now I don't know how to enchance it
        ExpireUserJob.all.each do |job|
            job_user = job.return_concerned_user

            if job_user == user
                job.destroy
                break
            end
        end

        UserReminderJob.set(wait: 3.month).perform_later(user)
        ExpireUserJob.set(wait: 3.month + 1.week).perform_later(user)
        session[:user_id] = user.id
        redirect_to "pages/something to say it's back on track"
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

    private

    def get_current_user
        if session[:user_id]
            @current_user = User.find(session[:user_id])
        end
    end
end
