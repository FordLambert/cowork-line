Rails.application.routes.draw do

    root 'pages#home'

    get 'pages/create', to: 'pages#create'
    get 'pages/success', to: 'pages#success'
    get 'pages/show', to: 'pages#show', as: 'utilisateur'
    get 'pages/disconnect', to: 'pages#disconnect'
    get 'pages/resend', to: 'pages#resend_email'
    get 'pages/:token', :to => "pages#confirm_email", as: 'confirm_email'

    post 'pages/create', to: 'pages#add_user'
    post 'pages/login', to: 'pages#login'

    delete 'pages/:id' => 'pages#destroy'
end
