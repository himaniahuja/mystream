Ishare::Application.routes.draw do
  resources :users  # give us our some normal resource routes for users
  resources :user_sessions
  
  match '/items/posted' => 'items#posted'
  match '/items/confirmed' => 'items#confirmed'
  match '/items/ordered' => 'items#ordered'
  
  
  resources :items
  resources :orders

  get "user_sessions/new"

  match 'login' => "user_sessions#new",      :as => :login
  match 'logout' => "user_sessions#destroy", :as => :logout
  match 'signup' => 'users#new', :as => :signup
  match '/dashboard' => 'users#dashboard'
  match '/order/confirm/:id' => 'orders#confirm'
  match '' => 'items#index'
  
resources :users  do
  resources :messages do
  end
end

  resources :comments

# give us our some normal resource routes for users
  # resource :user, :as => 'account'  # a convenience route
  
  match 'signup' => 'users#new', :as => :signup
  match 'myitems' => 'items#myitems', :as => :myitems
  match "/sendMessage" => "users#sendMessage"
  match "/messages" => "users#createMessage"
  match "/inbox" => "users#inbox"
  match "/outbox" => "users#outbox"
  match "/messages/:id" => "users#showMessage" , :as => :show_message
  match "/messages/:id/sent" => "users#showSentMessage" , :as => :show_sent_message
  match "/messages/:id/reply" => "users#replyMessage" , :as => :reply_message
  match "/messages/:id/replyMessage" => "users#createReplyMessage" , :as => :create_reply
  match "/messages/:id/delete" => "users#deleteMessage" , :as => :delete_message
  match "/user_profile/:user_id" => "items#user_profile", :as => :user_profile
  match "/deleteMessages(.:format)" => "users#deleteAllMessages", :as => :delete_messages

  # resource :user, :as => 'account'  # a convenience route
  
  
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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
