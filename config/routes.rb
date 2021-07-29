Rails.application.routes.draw do

  get 'likes/index'
  root 'welcome#index'
  get 'welcome/index'
  resources :posts
  devise_for :users, :controllers => {:sessions => "sessions",:registrations => "registrations"}
  resources :comments
  resources :likes
end
