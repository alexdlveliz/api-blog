class CommentsController < ApplicationController

  #GET /comments
  def index
    @comments = Comment.where(post_id: params[:post_id]).page(params[:page]).per(3)
    render json: @comments, status: :ok, include: ['user'], meta: pagination(@comments,params)
  end

  # GET /comments/{id}
  def show
    @comment = Comment.find(params[:id])
    render json: @comment, status: :ok
  end
  
  # POST /comments
  def create
    @comment = Comment.create!(create_params)
    render json: @comment, status: :created
  end

  # PUT /comments/{id}
  def update
    @comment = Comment.find(params[:id])
    @comment.update!(update_params)
    render json: @comment, status: :ok
  end

  private

  def create_params
    params.require(:comment).permit(:content, :user_id, :post_id)
  end

  def update_params
    params.require(:comment).permit(:content)
  end

  # Acá estructuro la información de la páginas que se esten enviando,
  # lo llamo con meta: pagination en los controladores que necesite.
  def pagination (object,params)
    if object.next_page != nil
      string_next = "/#{params[:controller]}?"
      string_next+="page=#{object.next_page}&post_id=#{params[:post_id]}"
    end
    if object.prev_page != nil
      string_prev = "/#{params[:controller]}?"
      string_prev+="page=#{object.prev_page}&post_id=#{params[:post_id]}"
    end
    meta={
      next_page: string_next,
      prev_page: string_prev,
      total_in_page: object.count
    }
    return meta
  end
end