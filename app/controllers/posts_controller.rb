class PostsController < ApplicationController
  before_action :authorize_request, except: :category
  before_action :set_post, only: [:show, :update]

  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index 
  # GET /posts
  # Para la paginación primero obtenemos nuestros datos en la página
  # que viene como parametro.
  # Despues se renderiza con adaptador json configurado en
  # config/initializers/active_model_serializer.rb
  # Luego se incluye la relación de usuarios y por último
  # damos un meta, que lleva la información de la páginación
  def index
    @posts = policy_scope(Post).page(params[:page])
    render json: @posts, status: :ok, include: ['user','category'] , meta: pagination(@posts,params)
  end

  def new
    @post = @current_user.posts.new
    authorize @post
  end

  # GET /posts/{id}
  def show
    render json: @post, status: :ok
  end

  # POST /posts
  def create
    @post = @current_user.posts.new(create_params)
    byebug
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

  def set_post
    @post = Post.find(params[:id])
    authorize @post
  end

  def create_params
    params.require(:post).permit(:title, :content, :published, :user_id,:category_id)
  end

  def update_params
    params.require(:post).permit(:title, :content, :published,:category_id)
  end

  # Acá estructuro la información de las siguientes páginas que contenga,
  # lo llamo con meta: pagination en los controladores que necesite.
  def pagination (object,params)
    if !object.next_page.nil?
      string_next = "/#{params[:controller]}"
      string_next += (params[:action]!="index")? "/#{params[:action]}" : ""
      string_next += "?page=#{object.next_page}"
      string_next += (params[:action]!="index")? "&id=#{params[:id]}" : ""
    end
    if !object.prev_page.nil?
      string_prev = "/#{params[:controller]}"
      string_prev += (params[:action]!="index")? "/#{params[:action]}" : ""
      string_prev += "?page=#{object.prev_page}"
      string_prev += (params[:action]!="index")? "&id=#{params[:id]}" : ""
    end
    meta={
      next_page: string_next,
      prev_page: string_prev,
      total_in_page: object.count
    }
    return meta
  end
end