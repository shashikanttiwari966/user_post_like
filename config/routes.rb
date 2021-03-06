Rails.application.routes.draw do
  root 'welcome#index'
  get 'welcome/index'
  resources :posts
  devise_for :users, :controllers => {:sessions => "sessions",:registrations => "registrations", omniauth_callbacks: 'users/omniauth'}
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  resources :comments
  resources :likes
  resources :billing
  resources :subscriptions
  post '/import' => 'welcome#import', :as=>'import'
  get '/search' => 'welcome#search', :as => 'search_post'
  get '/show_pdf' => 'welcome#show_pdf', :as => 'show_pdf'
  get '/show_users' => 'welcome#show_users', :as => 'show_users'
  post "/create_like_comment" => 'likes#create_like_comment', as: 'create_like_comment'
  delete "/destroy_like_comment" => 'likes#destroy_like_comment', as: 'destroy_like_comment'

  # create plan
  get '/plan/new' => 'billing#new_card', as: :add_payment_method
  post "/subscribe" => "billing#subscribe", as: :create_payment_method
  
  # add card
  get '/customer_info' => 'billing#customer_info', as: :customer_info
end

