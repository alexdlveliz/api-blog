#Archivo creado con factory Bot
require "rails_helper"
require "byebug"

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
    let!(:comment) { create(:comment, post_id: post.id) }

    it "should return a post" do
      get "/posts/#{post.id}"
      payload = JSON.parse(response.body)
      #Se hace otro get para probar los comentarios de un post
      get "/posts/#{post.id}/comments"
      payload_comments = JSON.parse(response.body)

      #Pruebas para el payload
      expect(payload).to_not be_empty
      expect(payload["id"]).to eq(post.id)
      expect(payload["title"]).to eq(post.title)
      expect(payload["content"]).to eq(post.content)
      expect(payload["published"]).to eq(post.published)
      expect(payload["author"]["name"]).to eq(post.user.name)
      expect(payload["author"]["email"]).to eq(post.user.email)
      expect(payload["author"]["id"]).to eq(post.user.id)

      #Pruebas para el payload_comments
      expect(payload_comments).to_not be_empty
      expect(payload_comments).to_not be_nil
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /posts" do
    #Prueba para crear un post
    let!(:user) { create(:user) }
    it "should create a post" do
      req_payload = {
        post: {
          title: "title",
          content: "content",
          published: false,
          user_id: user.id
        }
      }

      post "/posts", params: req_payload

      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload["id"]).to_not be_nil
      #Se espera que el estado del http sea 'created'
      expect(response).to have_http_status(:created)
    end

    #Prueba para cuando no se envíe un parámetro al crear un post
    it "should return error message on invalid post" do
      req_payload = {
        post: {
          content: "content",
          published: false,
          user_id: user.id
        }
      }

      post "/posts", params: req_payload

      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload["error"]).to_not be_empty
      #Se espera que el estado del http sea 'created'
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  #Prueba para editar un post
  describe "PUT /posts/{id}" do
    let!(:article) { create(:post) }

    it "should create a post" do
      req_payload = {
        post: {
          title: "title",
          content: "content",
          published: true
        }
      }

      put "/posts/#{article.id}", params: req_payload

      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload["id"]).to eq(article.id)
      #Se espera que el estado del http sea 'created'
      expect(response).to have_http_status(:ok)
    end

    #Prueba para cuando no se envíe un parámetro al editar un post
    it "should return error message on invalid post" do
      req_payload = {
        post: {
          title: nil,
          content: nil,
          published: false
        }
      }
  
      put "/posts/#{article.id}", params: req_payload
  
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload["error"]).to_not be_empty
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end