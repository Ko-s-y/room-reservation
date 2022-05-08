Rails.application.routes.draw do

  root to: 'pages#home'

  devise_for :users, path: '', path_names: {sign_up: 'register', sign_in: 'login', sign_out: 'logout'}


################################################################


  post 'reservations/confirmation', to: 'reservations#confirm'
  post 'room/:id/show', to: 'reservations#confirm'
  post 'reservations/:id/confirmation', to: 'reservations#create'

  # post 'reservations/new', to:  'reservations#create' これは確認フォーム通らん
  get 'reservations/show', to: 'reservations#show'
  patch 'reservations', to: 'reservations#create' #とりあえず


################################################################
  get 'reservations/:id/show', to: 'reservations#show'
  get 'reservations', to: 'reservations#index'

  get 'pages/home'

  get '/users/:id/info', to: 'users#info'
  get '/users/:id/show', to: 'users#show'
  get '/users/edit.:id', to: 'users#show'  #画像、自己紹介を更新した際のページエラー回避
  post '/users/edit', to: 'users#update'

  get '/rooms/:id/show', to: 'rooms#show'
  get '/rooms/registered', to: 'rooms#registered'
  get '/rooms/index', to: 'rooms#index'

  get '/reservations/confirmation', to: 'reservations#confirmation'

  resources :rooms

  resources :reservations

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
