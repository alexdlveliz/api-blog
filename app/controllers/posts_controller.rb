require 'pagination'
class PostsController < ApplicationController

  # GET /posts
  # Para la paginación primero obtenemos nuestros datos.
  # luego de eso necesitamos incluir la librería pagination.
  # luego en el render instanciamos la clase paginación con su método
  # le mandamos los datos.
  # Pagination.build_json se encuentra en lib/pagination.rb
  def index
    @posts = Post.where(published: true).page(params[:page])
    authorize @posts
    render json: Pagination.build_json(@posts), status: :ok
  end

  # GET /posts/{id}
  def show
    @post = Post.find(params[:id])
    authorize @post
    render json: @post, status: :ok
  end

  # POST /posts
  def create
    @post = Post.create!(create_params)
    authorize @post
    render json: @post, status: :created
  end

  # PUT /posts/{id}
  def update
    @post = Post.find(params[:id])
    @post.update!(update_params)
    authorize @post
    render json: @post, status: :ok
  end

  def pundit_user
    @user
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