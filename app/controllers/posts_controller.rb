class PostsController < ApplicationController

  # GET /posts
  # Para la paginación primero obtenemos nuestros datos en la página
  # que viene como parametro.
  # Despues se renderiza con adaptador json configurado en
  # config/initializers/active_model_serializer.rb
  # Luego se incluye la relación de usuarios y por último
  # damos un meta, que lleva la información de la páginación
  def index
    @posts = Post.where(published: true).page(params[:page])
    authorize @posts
    render json: @posts, status: :ok, include: ['user'] , meta: pagination(@posts)
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