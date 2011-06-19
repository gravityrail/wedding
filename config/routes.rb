Wedding::Application.routes.draw do

  match '/events/:id(/:email)', :controller => 'events', :action => 'show', :email => /[^\/]+/, :as => 'show_event'

  resources :events do
    resources :rsvps
    match 'rsvps/complete/:email', :controller => 'rsvps', :action => 'complete', :email => /[^\/]+/, :as => 'complete_rsvp'
  end

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
  
  root :to => 'pages#home'
 
end
