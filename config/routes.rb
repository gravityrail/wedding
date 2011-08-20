Wedding::Application.routes.draw do

  match '/users/without_location' => 'pages#user_addresses', :as => 'user_addresses'
  
  resources :users
  
  resources :events do
    resources :rsvps
    match 'badges', :action => 'badges'
    match 'badges_pdf', :action => 'badges_pdf'
    match 'attendees', :action => 'attendees'
    match 'rsvps/complete/:email', :controller => 'rsvps', :action => 'complete', :email => /[^\/]+/, :as => 'complete_rsvp'
  end
  
  match '/events/:id(/:email)', :controller => 'events', :action => 'show', :email => /[^\/]+/, :as => 'show_event'

  devise_for :user, 
    :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" },
    :path_names => { :sign_in => 'login', 
                     :sign_out => 'logout', 
                     :password => 'secret', 
                     :confirmation => 'verification', 
                     :unlock => 'unlock', 
                     :registration => 'register', 
                     :sign_up => 'signup' }
  
#  namespace :admin do
#    resources :users
#    match '/audit_trail' => 'audit_trail#show#'
#  end
  
  match "/logout" => "users/omniauth_callbacks#destroy", :as => :signout

  match "/download" => "pages#download_domains"
  
  match "/about" => "pages#about"

  match "/rsvps/search" => "rsvps#search"

  match "/rsvp_tahoe" => "pages#rsvp_tahoe"
  match "/rsvp_melbourne" => "pages#rsvp_melbourne"
  
  #generic routes for callme controller
  match ':controller(/:action(.:format))'
  match ':controller(/:action(/:id(.:format)))'
  
  root :to => 'pages#home'
 
end
