Clubber::Application.routes.draw do

  devise_for :users

  #resources :points, :except => [:show, :new]
  #resources :events

  #match 'p/v/:event_point_id' => 'events#visit_point'
  #delete 'events/delete_point/:id' => 'events#delete_point', :as => :delete_event_point
  #put 'events/add_point/:id' => 'events#add_point', :as => :add_event_point

  match "/i/:id" => "qr_items#visit"
  delete "/qr_items/destroy/:id" => "qr_items#destroy", :as => :destroy_qr_item
  match "/qr_items/list(/:type)" => "qr_items#list", :as => :qr_items_list 
  match "/qr_items/:type(/:id)" => "qr_items#item", :as => :qr_item

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  root :to => "qr_items#list", :type => 'vcard'
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  match ':controller(/:action(/:id(.:format)))'
end
