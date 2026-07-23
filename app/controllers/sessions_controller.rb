class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: [:create]

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      # returns users data and 'Success' (200) 
      render json: { token: token }, status: :ok

    else
      # returns 'Not authenticated' (401)
      render json: { message: "Invalid credentials!" }, status: :unauthorized
    end
  end

  def show
    render json: @current_user, serializer: UserSerializer, status: :ok
  end

  def destroy
    render json: { message: "Logged out successfully" }, status: :ok
  end

end