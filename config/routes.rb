Rails.application.routes.draw do
  devise_for :customers, controllers: { sessions: 'customers/sessions' }

  devise_scope :customer do
    get 'sign_out', to: 'devise/sessions#destroy', as: :destroy_customer_session_get
  end

  post 'complete_checkout', to: 'carts#complete_checkout', as: 'complete_checkout'
  resources :checkouts, only: [:new, :create]
  resources :orders, only: [:index, :show, :create] do
    resources :payments, only: [:new, :create]
  end

  resources :customers, only: [:new, :create, :show] do
    member do
      get :past_orders
    end
  end

  # Categories routes
  resources :categories, only: [:index, :show] do
    resources :products, only: [:index, :show]
  end

  resource :cart, only: [:show] do
    post 'add_item', to: 'carts#add_item'
    delete 'remove_item', to: 'carts#remove_item'
  end

  # Products routes
  resources :products do
    collection do
      get 'recently_updated'
      get 'new_products'
      get 'search'
      get 'search_by_category'
    end
  end

  # Static pages routes
  resource :about_page, only: :show, path: 'about'
  resource :contact_page, only: :show, path: 'contact'

  # Admin routes
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Root route
  root 'products#index'

  # Health check route
  get 'up' => 'rails/health#show', as: :rails_health_check
end
