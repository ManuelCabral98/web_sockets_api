class JsonWebToken
    SECRET_KEY = Rails.application.secret_key_base

    def self.encode(payload, exp = 24.hours.from_now)
        # add expiration to 'payload'. Payload is the data. E.g: {user_id: 1, username: luis123} 
        payload[:exp] = exp.to_i

        # encode data
        JWT.encode(payload, SECRET_KEY, 'HS256')
    end

    def self.decode(token)
        decoded = JWT.decode(token, SECRET_KEY, true, { algorithm: 'HS256' })
        # use first element of decoded. It's 'payload'
        decoded[0]
    # grep possible decoding error. Returns 'nil'. Avoid crash
    rescue JWT::DecodeError
        nil
    end
end