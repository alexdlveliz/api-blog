require "byebug"
class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :published, :author, :comments

  #En los atributos definimos un 'author', pero debido a que
  #en el modelo 'author' no existe, para eso declaramos el 
  #método author: 
  def author
    user = self.object.user
    {
      name: user.name,
      email: user.email,
      id: user.id
    }
  end
end
