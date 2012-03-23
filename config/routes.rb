OauthProviderDemo::Application.routes.draw do
  devise_for :users, :controllers => { :registrations => 'registrations',
                                       :sessions => 'sessions'}
  # omniauth client stuff
  match '/auth/:provider/callback', :to => 'authentications#create'
  match '/auth/failure', :to => 'authentications#failure'

  # Provider stuff
  match '/auth/neuro/authorize' => 'auth#authorize'
  match '/auth/neuro/access_token' => 'auth#access_token'
  match '/auth/neuro/user' => 'auth#user'
  match '/oauth/token' => 'auth#access_token'

  # Account linking
  match 'authentications/:user_id/link' => 'authentications#link', :as => :link_accounts
  match 'authentications/:user_id/add' => 'authentications#add', :as => :add_account

  root :to => 'auth#welcome'
end
