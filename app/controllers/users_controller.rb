class UsersController < ApplicationController
  # avoid authenticate_user while create request, because user still don't have a token
  skip_before_action :authenticate_user, only: [:create]

  def create
    # create a new user. user_params makes sure that info is valid
    @user = User.new(user_params)

    # if user correctly save in DB
    if @user.save
      # return message to login
      render json: {message: "User created. Please login!"}, status: :created
    else
      # return errors
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    # search for the user by its 'id'
    @user = User.find(params[:id])

    # if update saves correctly then
    if @user.update(user_params)
      # return updated data
      render json: @user, serializer: UserSerializer, status: :ok
    else
      # return errors
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
    render json: @user, serializer: UserSerializer
  end

  def destroy
    # find by its 'id'
    @user = User.find(params[:id])

    if @user.destroy
      render json: { message: "Deleted succesfully!" }, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  def user_params
    # establish what params are allowed when creating a new user
    params.require(:user).permit(:username, :password)
  end
end
