# Rails.application.routes.draw do
#   get 'categories/index'
#   get 'categories/show'
#   get 'products/index'
#   get 'products/show'
#   devise_for :admin_users, ActiveAdmin::Devise.config
#   ActiveAdmin.routes(self)
#   # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
#   root 'products#index'
#   resources :categories, only: [:index, :show] do
#     resources :products, only: [:index, :show]
#   end
#   resources :products, only: [:index, :show]
#   # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
#   # Can be used by load balancers and uptime monitors to verify that the app is live.
#   get "up" => "rails/health#show", as: :rails_health_check
#    get 'products/new_products', to: 'products#new_products', as: 'new_products'
#   get 'products/recently_updated', to: 'products#recently_updated', as: 'recently_updated'

#   # Defines the root path route ("/")
#   # root "posts#index"
# end
Rails.application.routes.draw do
  get 'categories/index'
  get 'categories/show'
  get 'products/index'
  get 'products/show'
  resource :about_page, only: :show, path: 'about'
  resource :contact_page, only: :show, path: 'contact'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'products#index'
  resources :products do
    collection do
      get 'recently_updated', to: 'products#recently_updated'
      get 'new_products', to: 'products#new_products'
       get 'search', to: 'products#search'
      get 'search_by_category', to: 'products#search_by_category'
    end
  end
  resources :categories, only: [:index, :show] do
    resources :products, only: [:index, :show]
  end
  # resources :about_pages, only: [:show]
  # resources :contact_pages, only: [:show]
  # resources :products, only: [:index, :show] do
  #   collection do
  #     get 'on_sale'
  #     get 'new_products'
  #     get 'recently_updated'
  #   end
  # end

  # Route for searching all products regardless of category
  # get 'products/search', to: 'products#search', as: 'search_products'
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
