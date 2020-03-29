class CategoriesController < ApplicationController
  
  #GET /categories
  def index
    @categories = Category.all
    render json: @categories, status: :ok
  end

  #GET /categories/{id}
  def show
    @category = Category.find(params[:id])
    render json: @category, status: :ok
  end

  # POST /categories
  def create
    @category = Category.create!(category_params)
    render json: @category, status: :created
  end

  # PUT /categories/{id}
  def update
    @category = Category.find(params[:id])
    @category.update!(category_params)
    render json: @category, status: :ok
  end

  private

  def category_params
    params.permit(:name_category)
  end
end