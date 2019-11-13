Rails.application.routes.draw do
  resources :users 
  resources :followings
  
  resources :posts do
    member do
      post 'eval'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'auth/registrations'
  }

  get 'user/:id', to: 'users#show'
  
end
