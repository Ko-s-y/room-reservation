Rails.application.routes.draw do



  root to: 'pages#home'
  devise_for :users, path: '', path_names: {sign_up: 'register', sign_in: 'login', edit: 'profile', sign_out: 'logout'}
  get 'pages/home'

  get '/users/:id/info', to: 'users#info'
  get '/users/:id/show', to: 'users#show'

  post '/users/edit', to: 'users#update'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
