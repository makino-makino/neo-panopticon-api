Rails.application.routes.draw do
  resources :evaluations
  resources :users 
  resources :followings
  resources :notifications
  
  resources :posts do
    member do
      post 'eval'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'auth/registrations'
  }

  put 'followings/:id', to: 'followings#update'

end
