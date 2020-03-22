#Archivo creado con factory Bot
require "rails_helper"

RSpec.describe "Posts", type: :request do
  describe "GET /posts" do
    #Prueba para mostrar los posts
    
    it "should return OK" do
      get '/posts'
      payload = JSON.parse(response.body)
      expect(payload).to be_empty
      expect(response).to have_http_status(200)
    end
  end

  describe "with data in the DB" do
    #Se utilizará factory_bot para crear información  de ejemplo
    #Se utiliza para declarar una variable 'posts' a la cual se le asignará lo que 
    #se ponga dentro del bloque

    #Método let pertenece a la gema 'rspec'
    let!(:posts) {
      #create_list pertenece a la gema 'factory_bot'
      create_list(:post, 10, published: true) }
    
    it "should return all the published posts" do
      get '/posts'
      #En este caso el payload sería una lista de posts
      payload = JSON.parse(response.body)
      #Se debe esperar que el 'payload' sea igual al tamaño
      #del símbolo :posts
      expect(payload.size).to eq(posts.size)
      #Se espera que la respuesta obtenida sea un 200
      expect(response).to have_http_status(200)
    end
  end
  
  #Prueba para mostrar un post en específico
  describe "GET /post/{id}" do
    #Se utilizará factory_bot para crear posts de ejemplo
    let!(:post) { create(:post) }

    it "should return a post" do
      get "/posts/#{post.id}"
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload["id"]).to eq(post.id)
      expect(response).to have_http_status(200)
    end
  end
end