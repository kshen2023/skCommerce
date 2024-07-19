# # Rails.application.routes.draw do
#   get 'carts/show'
#   get 'carts/add_item'
#   get 'carts/remove_item'
# #   get 'categories/index'
# #   get 'categories/show'
# #   get 'products/index'
# #   get 'products/show'
# #   devise_for :admin_users, ActiveAdmin::Devise.config
# #   ActiveAdmin.routes(self)
# #   # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
# #   root 'products#index'
# #   resources :categories, only: [:index, :show] do
# #     resources :products, only: [:index, :show]
# #   end
# #   resources :products, only: [:index, :show]
# #   # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
# #   # Can be used by load balancers and uptime monitors to verify that the app is live.
# #   get "up" => "rails/health#show", as: :rails_health_check
# #    get 'products/new_products', to: 'products#new_products', as: 'new_products'
# #   get 'products/recently_updated', to: 'products#recently_updated', as: 'recently_updated'

# #   # Defines the root path route ("/")
# #   # root "posts#index"
# # end
# Rails.application.routes.draw do
#   get 'categories/index'
#   get 'categories/show'
#   get 'products/index'
#   get 'products/show'
#   resource :about_page, only: :show, path: 'about'
#   resource :contact_page, only: :show, path: 'contact'
#   devise_for :admin_users, ActiveAdmin::Devise.config
#   ActiveAdmin.routes(self)

#   resource :cart, only: [:show] do
#     post 'add_item/:product_id', to: 'carts#add_item', as: 'add_item'
#     delete 'remove_item/:product_id', to: 'carts#remove_item', as: 'remove_item'
#   end


#   # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
#   root 'products#index'
#   resources :products do
#     collection do
#       get 'recently_updated', to: 'products#recently_updated'
#       get 'new_products', to: 'products#new_products'
#        get 'search', to: 'products#search'
#       get 'search_by_category', to: 'products#search_by_category'
#     end
#   end
#   resources :categories, only: [:index, :show] do
#     resources :products, only: [:index, :show]
#   end
#   # resources :about_pages, only: [:show]
#   # resources :contact_pages, only: [:show]
#   # resources :products, only: [:index, :show] do
#   #   collection do
#   #     get 'on_sale'
#   #     get 'new_products'
#   #     get 'recently_updated'
#   #   end
#   # end

#   # Route for searching all products regardless of category
#   # get 'products/search', to: 'products#search', as: 'search_products'
#   # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
#   # Can be used by load balancers and uptime monitors to verify that the app is live.
#   # get "up" => "rails/health#show", as: :rails_health_check

#   # Defines the root path route ("/")
#   # root "posts#index"
# end
Rails.application.routes.draw do

  post 'complete_checkout', to: 'carts#complete_checkout', as: 'complete_checkout'

  resources :orders, only: [:new, :create, :show]
  resources :customers, only: [:new, :create, :show]
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

  # Cart routes


  # Root route
  root 'products#index'

  # Health check route
  get 'up' => 'rails/health#show', as: :rails_health_check
end
