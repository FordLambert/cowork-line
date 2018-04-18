Rails.application.routes.draw do

    root 'pages#home'

    get 'pages/create'
    get 'pages/show', to: 'pages#show', as: 'utilisateur'
    get 'pages/disconnect', to: 'pages#disconnect'

    post 'pages/create', to: 'pages#create'
    post 'pages/login', to: 'pages#login'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
