module ApplicationCable
  class Connection < ActionCable::Connection::Base
    # used for identify a user
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private
    def find_verified_user
      # get 'token' from URL params
      token = request.params[:token]
      # decode with JsonWebToken decode method to get 'Payload'
      payload = JsonWebToken.decode(token)
      # search users by their 'id'
      User.find(payload[:user_id])
    # if user not found or decoding fails, reject connection
    rescue
      reject_unauthorized_connection
    end
  end
end
