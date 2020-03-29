Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #Haciendo un get a la ruta /health
    #Vaya al controlador healt y al método health
  get '/health', to: 'health#health'
  
  #Rutas para los posts
  resources :posts do
    get 'page/:page', action: :index, on: :collection
    member do 
      get :comments
    end
  end

  #Rutas para las categoríass
  resources :categories, only: [:index, :show, :create, :update]

  #Rutas para los comentarios
  resources :comments, only: [:index, :show, :create, :update]

  #Rutas para la authentication
  resources :users, param: :_username
  post '/auth/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'

end
