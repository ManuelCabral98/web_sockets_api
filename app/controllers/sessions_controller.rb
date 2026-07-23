class SessionsController < ApplicationController

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      # set session
      session[:user_id] = @user.id
      # returns users data and 'Success' (200) 
      render json: { success: true, user: @user }, status: :ok

    else
      # returns 'Not authenticated' (401)
      render json: { success: false, message: "Invalid credentials!" }, status: :unauthorized
    end
  end

  def destroy
  end

end