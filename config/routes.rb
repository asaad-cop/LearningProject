Rails.application.routes.draw do
  get 'users', to: 'pages#users'
  resources :projects
  devise_for :users, path: '', path_names: {sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  resources :bugs
  root "pages#home"
  get '/projects/:id/newuser/:id2', to: 'projects#newuser', as: 'userdelete'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
