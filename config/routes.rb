Rails.application.routes.draw do

    root 'pages#home'

    get 'pages/create'
    get 'pages/show'  => 'pages#show'
    get 'pages/disconnect' => 'pages#disconnect'

    post 'pages/create' => 'pages#add_user'
    post 'pages/login' => 'pages#login'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
