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
  resources :webhooks, only: [:create]
  resources :phone_numbers, only: [:new, :create]
  post 'phone_numbers/verify' => "phone_numbers#verify"

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

  # webhook
  # mount StripeEvent::Engine, at: 'api/webhook/stripe'

  # post '/webhook/chuck' => 'webhook#chuck_request', format: :json

  # post 'api/webhook/stripe' => "api/webhook/stripe#webhook", format: :json
end

