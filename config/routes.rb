Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #Haciendo un get a la ruta /health
    #Vaya al controlador healt y al método health
  get '/health', to: 'health#health'
end
