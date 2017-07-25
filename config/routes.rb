Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  resources :posts
  devise_for :users
  resources :users, only: [:show]
  resources :comments
  resources :likes, only: [:new, :create, :destroy]

  delete '/likes/',            to: 'likes#destroy'
  get    '/likes/',            to: 'likes#get_likers'
  delete '/follow/',           to: 'user_followers#destroy'
  post   '/follow/',           to: 'user_followers#create'
  get    '/friends/',          to: 'user_followers#index'
  get    '/share/:id',         to: 'posts#share', :as => :share_post
  delete '/followRequest/',    to: 'follow_requests#destroy'
  post   '/followRequest/',    to: 'follow_requests#create'
  get    '/followRequests/',   to: 'follow_requests#index', :as => :follow_requests
  get    '/userspdf/:id',      to: 'users#create_pdf', :as => :create_pdf


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

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
