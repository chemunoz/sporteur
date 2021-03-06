Rails.application.routes.draw do
  root 'site#index'
  
  devise_for :users

  #redirect after edit profile
  get 'user_root' => redirect('/users')

  get 'matches/join/:id' => 'matches#join', as: 'join_team'

  post 'matches/:id/score' => 'matches#score', as: 'match_score'
  post 'matches/:id/rivals' => 'matches#handicap_rivals', as: 'match_rivals'
  
  patch 'users/:user_id/matches/:id' => 'matches#update'
  patch 'matches/:id/score' => 'matches#score'

  get 'users/rankings' => 'users#rankings'
  
  resources :matches, only: [:index, :show, :edit, :update] do
    resources :teams, only: [:index, :show]
  end
  
  resources :users, only: [:index, :show] do
    resources :matches, only: [:index, :show, :new, :create, :edit, :destroy]  do
      resources :teams, only: [:index, :new, :show, :create]
    end
  end

  resources :matches, only: [:index, :show, :edit, :update] do
    resources :comments, only: [:create]
  end
  




  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

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
