class UserSerializer < ActiveModel::Serializer
  # allow send only 'id' and 'username' in JSON response
  attributes :id, :username
end
