Jubeo::Application.routes.draw do
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get "users/show"
  post 'steps/:step_id/step_achievements', to: 'step_achievements#create', as: 'step_step_achievements'
  root 'pages#home'
  get 'dashboard' => 'tracks#index_attending_tracks'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :registrations => "registrations" } 
  

  resources :tracks do
    resources :steps
    resources :attendings
  end

  resources :ratings, only: [:update, :create]


  get '/users/:user_id/owned_tracks', to: 'tracks#index_owned_tracks', as: 'user_owned_tracks'
  get '/users/:user_id/attending_tracks', to: 'tracks#index_attending_tracks', as: 'user_attending_tracks'

  get 'users/:id' => 'users#show', as: 'user_profile'

  get'/blog' => 'blogs#index'

  get '/blog/:title' => 'blogs#show'
  
  post '/tracks/:id/comments/new' => 'comments#create', as: 'track_comments'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".




  # You can have the root of your site routed with "root"
  

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
