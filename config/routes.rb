Rails.application.routes.draw do
  devise_for :admins, :controllers => { registrations: 'admin_registrations' }
  devise_for :users, :controllers => { omniauth_callbacks: "users/omniauth_callbacks", registrations: 'user_registrations'  }
  resources :proposals
  resources :fees
  resources :milestones

  root to: "pages#index"


  get '/users/sign_out' => 'devise/sessions#destroy'
  get '/admins/sign_out' => 'devise/sessions#destroy'
  get '/sort', to: 'pages#sort', as: "sort"
  get '/creative', to: 'pages#creative'
  get '/profile', to: 'pages#profile'
  get '/company', to: 'pages#company'
  get '/dash', to: 'pages#dash'
  get '/cmpny', to: 'pages#companydash'
  get '/crtv', to: 'pages#creativedash'
  get '/proposals', to: 'proposals#index'
  get '/proposals/:id/sign', to: 'proposals#sign', as: "sign"
  patch '/proposals/:id/sign', to: 'proposals#sign_check', as: "verify"
  delete '/proposals/:id/delete', to: 'proposals#destroy', as: "delete"

end
