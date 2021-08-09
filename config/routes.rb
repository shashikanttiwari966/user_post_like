Rails.application.routes.draw do

  get 'likes/index'
  root 'welcome#index'
  get 'welcome/index'
  resources :posts
  devise_for :users, :controllers => {:sessions => "sessions",:registrations => "registrations", omniauth_callbacks: 'users/omniauth'}
  resources :comments
  resources :likes
  get '/search' => 'welcome#search', :as => 'search_post'
  post "/create_like_comment" => 'likes#create_like_comment', as: 'create_like_comment'
  delete "/destroy_like_comment" => 'likes#destroy_like_comment', as: 'destroy_like_comment'
end
