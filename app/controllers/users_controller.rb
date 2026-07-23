class UsersController < ApplicationController
  # avoid authenticate_user while create request, because user still don't have a token
  skip_before_action :authenticate_user, only: [ :create ]

  def create
    # create a new user. user_params makes sure that info is valid
    @user = User.new(user_params)

    # if user correctly save in DB
    if @user.save
      # encode payload (user_id) with JWT
      token = JsonWebToken.encode(user_id: @user.id)

      # return json with data. 'UserSerializer' use for avoid sending password_digest in JSON response
      render json: @user, serializer: UserSerializer, meta: { token: token }, status: :created
    else
      # return errors
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
  end

  private
  def user_params
    # establish what params are allowed when creating a new user
    params.require(:user).permit(:username, :password)
  end
end
