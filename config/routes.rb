ScottishEntrepreneurialSupportNetwork::Application.routes.draw do

  resources :footers

  root "home#index"
  get "embed", to: "home#embed", as: "embed"


  get  "login",   to: "login#index",  as: "login"
  get  "logout",  to: "login#logout", as: "logout"
  post "login",   to: "login#login"
  get  "signup",  to: "login#signup", as: "signup"
  post "signup", to: "login#signup"

  namespace :admin do
    root 'organisations#index'
    get "/organisations/tree(.:format)", to: "organisations#tree", as: "tree_organisation"
    get "preferences", to: "preferences#index", as: "preferences"
    patch "preferences", to: "preferences#update"
    put   "preferences", to: "preferences#update", as: "update_preferences"
    resources :organisations
    resources :tags
    resources :categories
    resources :footers
    resources :headers
    resources :search_types do
      resources :searches
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
