PasswordPusher::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :p, :controller => :passwords, :as => :passwords, :except => :index
  match 'passwords/:url_token/admin' => 'passwords#admin', :as => :pwadmin

  match 'dashboard' => 'users#show', :as => :dashboard
  
  root :to => 'passwords#new'
  
  match 'pages/about' => 'high_voltage/pages#show', :id => 'about'
  
  unless Rails.application.config.consider_all_requests_local
    match '*not_found', to: 'errors#error_404'
  end
end
