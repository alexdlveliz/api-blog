class UsersController < ApplicationController
  before_action :authorize_request, except: :create
  before_action :find_user, except: %i[create index]

  # GET /users
  def index
    if make_sure
      @users = User.all
      render json: @users, status: :ok
    end
  end

  # GET /users/{username}
  def show
    if make_sure
      render json: @user, status: :ok
    end
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages },
      status: :unprocessable_entity
    end
  end

  # PUT /users/{username}
  def update
    if make_sure
      unless @user.update(user_params)
        render json: { errors: @user.errors.full_messages },
        status: :unprocessable_entity
      end
    else
      puts "Error"
    end
  end

  private
  def make_sure
    user_make_sure = User.find_by(id: @current_user.id)
    unless user_make_sure.role == 'guest' || user_make_sure.role == 'writer'
      return user_make_sure
    end
  end

  def find_user
    @user = User.find_by_username!(params[:_username])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'User not found' }, status: :not_found 
  end

  def user_params
    params.permit(
              :email, 
              :username, 
              :name, 
              :password, 
              :password_confirmation, 
              :role
    )
  end

end