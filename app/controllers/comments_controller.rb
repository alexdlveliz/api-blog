class CommentsController < ApplicationController

  #GET /comments
  def index
    @comments = Comment.all
    render json: @comments, status: :ok
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
end