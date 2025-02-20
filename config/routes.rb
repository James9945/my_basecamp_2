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

  
  resources :admin_dashboard, only: [:index] do
    member do
      patch :update_role  # Ensure this is inside `member`
    end
  end

  resources :projects do
    resources :discussions do
      resources :messages, only: [:create, :edit, :update, :destroy]
    end
  end
 
end

