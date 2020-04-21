class PostsController < ApplicationController
  include PaginationConcern
  before_action :authorize_request, except: [:index, :show, :category]

  after_action :verify_authorized, except: [:index, :show, :category]
  # GET /posts
  # Para la paginación primero obtenemos nuestros datos en la página
  # que viene como parametro.
  # Despues se renderiza con adaptador json configurado en
  # config/initializers/active_model_serializer.rb
  # Luego se incluye la relación de usuarios y por último
  # damos un meta, que lleva la información de la páginación
  def index
    @posts = Post.where(published: true).page(params[:page])
    render json: @posts, status: :ok, include: ['user','category'] , meta: pagination(@posts,params)
  end

  def new
    @post = @current_user.posts.new
    authorize @post
  end

  # GET /posts/{id}
  def show
    @post = Post.find(params[:id])
    render json: @post, status: :ok
  end

  # POST /posts
  def create
    @post = @current_user.posts.new(create_params)
    authorize @post
    if @post.save
      render json: @post, status: :created
    else
      render json: { errors: @post.errors.full_messages }
    end
  end

  # PUT /posts/{id}
  def update
    @post = Post.find(params[:id])
    @post.update!(update_params)
    authorize @post
    render json: @post, status: :ok
  end

  def pundit_user
    User.find_by(id: @current_user.id)
  end

  # GET /posts/{id}/comments
  def comments
    @post = Post.find(params[:id]).comments
    render json: @post, status: :ok  
  end

  def category
    @posts = Post.where(published: true,
    category_id: params[:id]).page(params[:page])
    render json: @posts, status: :ok, include: ['user'], meta: pagination(@posts,params)
  end

  private
  def create_params
    params.require(:post).permit(:title, :content, :published, :user_id,:category_id)
  end

  def update_params
    params.require(:post).permit(:title, :content, :published,:category_id)
  end
end