class ApplicationController < ActionController::API
    # execute 'authenticate_user' before any request
    before_action :authenticate_user

    def authenticate_user
        # read HTTP header
        header = request.headers['Authorization']

        # grab token. E.g: 'Bearer token123' gets -> 'token123'. '&' use for avoid crash if value is nil
        token = header&.split(' ')&.last

        # decodes token. If correct, returns payload (E.g: { user_id: 1, username: ... })
        payload = JsonWebToken.decode(token)

        # find user in DB by id if payload is exists
        @current_user = User.find_by(id: payload[:user_id]) if payload

        # return HTTP 401 if @current_user = nil
        render json: { error: 'Unauthorized' }, status :unauthorized unless @current_user
end
