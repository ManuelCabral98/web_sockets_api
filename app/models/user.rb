class User < ApplicationRecord
    has_secure_password
    validates :username, uniquess: true, presence: true    
end
