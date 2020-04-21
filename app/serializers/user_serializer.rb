# Definimo los atributos que necesitemos
# asociamos comentarios y posts para utilizarlos
# posteriormente si es necesario
class UserSerializer < ActiveModel::Serializer
  attributes :name, :username, :id
  has_many :posts
  has_many :comments
end
