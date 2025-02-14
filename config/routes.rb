Rails.application.routes.draw do
  namespace :admin do
    get "users/index"
    get "users/edit"
    get "users/update"
  end
  get "admin_dashboard/index"
  get "home/index"
  devise_for :users
  resources :projects

  resources :projects do
    resources :attachments, only: [:create, :destroy]
  end

  resources :projects do
    resources :discussions, only: [:new, :create, :destroy]
  end
  
  root "home#index"

  get "admin_dashboard", to: "admin_dashboard#index"

  namespace :admin_dashboard do
    resources :users, only: [:index] do
      member do
        patch :update_role
      end
    end
  end

  
  resources :projects do
    resources :discussions, only: [:new, :create, :show, :destroy] do
      resources :messages, only: [:create, :edit, :update, :destroy]
    end
  end
  
  
  

  
end
