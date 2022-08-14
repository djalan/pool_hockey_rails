Pool::Application.routes.draw do

  controller :home do
    get 'home', to: 'home#all'
    get "home/index"
    get "home/edit"
    get "home/pp"
    get 'home/i'
    get 'home/test'
    get 'home/team'
    get 'home/team_roster'
    get '/home/alainhello'
    get '/home/alainbye'
    get '/home/set_year'
    
    get   'home/all'
    post  'home/all'
    get   'home/skaters'
    post  'home/skaters'
    get   'home/wingers'
    post  'home/wingers'
    get   'home/centers'
    post  'home/centers'
    get   'home/defenders'
    post  'home/defenders'
    get   'home/goalers'
    post  'home/goalers'
    
    get   'home/skaters_rank'
    post  'home/skaters_rank'
    get   'home/skaters_global'
    post  'home/skaters_global'
    get   'home/wingers_rank'
    post  'home/wingers_rank'
    get   'home/centers_rank'
    post  'home/centers_rank'
    get   'home/defenders_rank'
    post  'home/defenders_rank'
    get   'home/goalers_rank'
    post  'home/goalers_rank'
    
    get 'home/pplast'
    get 'home/standings'
    get 'home/draft'
  end
  
  
  resources :players do
    post  'edit_individual', on: :collection
    put   'update_individual', on: :collection
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#draft'

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
