class PostsController < ApplicationController

  #El rescue_from que más abajo se encuentre, más prioridad va a tener
  #rescue_from para el manejo de excepciones. Es importante para las 
  #pruebas que se hicieron
  rescue_from Exception do |e|
    render json: { error: e.message }, status: :internal_error
  end

  rescue_from ActiveRecord::RecordInvalid do |e|
    render json: { error: e.message }, status: :unprocessable_entity
  end

  # GET /posts
  # Para paginar necesitamos nuestros datos, pero ahora le damos un
  # metodo llamado page en el cual recibe como parametro el número de página
  # después el metodo per tiene que ver con la cantidad de datos que enviaremos
  # por página.
  # json_response contiene un header con los siguientes datos:
  # total de datos en página, el número de la página siguiente y el número
  # de la página anterior.
  # En el body enviamos los datos que contiene nuestra consulta.
  def index
    @posts = Post.where(published: true).page(params[:page]).per(5)
    json_response={
      total_pagina: @posts.count,
      pagina_siguiente: @posts.next_page,
      pagina_anterior: @posts.prev_page,
      datos: @posts
    }
    render json: json_response, status: :ok
  end

  # GET /posts/{id}
  def show
    @post = Post.find(params[:id])
    render json: @post, status: :ok
  end

  # POST /posts
  def create
    @post = Post.create!(create_params)
    render json: @post, status: :created
  end

  # PUT /posts/{id}
  def update
    @post = Post.find(params[:id])
    @post.update!(update_params)
    render json: @post, status: :ok
  end

  # GET /posts/{id}/comments
  def comments
    @post = Post.find(params[:id]).comments
    render json: @post, status: :ok
  end

  private
  
  def create_params
    params.require(:post).permit(:title, :content, :published, :user_id)
  end

  def update_params
    params.require(:post).permit(:title, :content, :published)
  end
end