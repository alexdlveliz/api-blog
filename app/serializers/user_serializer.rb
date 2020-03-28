class UserSerializer < ActiveModel::Serializer
  attributes :name, :email, :username, :id
end
