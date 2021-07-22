Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'users#index'
  get '/register', to: 'users#register'
  get '/reports', to: 'users#reports'
  get '/addreport', to: 'users#add_report'
  post '/create', to: 'users#create'
  post '/login', to: 'users#login'
  get '/home', to: 'users#home'
  post '/createreport', to: 'users#create_report'
  get '/logout', to: 'users#logout'
end
