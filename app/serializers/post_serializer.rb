# Definimos los atributos que necesitemos
# agregamos la asociación que tiene post con user
# una función que nos regresa solo la fecha sin la hora
# y otra función donde enviamos el url de los comentarios
# de x post
class PostSerializer < ActiveModel::Serializer
  attributes :title, :content, :creation, :comments_link
  has_many :category do
    category = self.object.category
    {
      name: category.name_category,
    }
  end
  belongs_to :user
  def creation
    fecha = self.object[:created_at]
    fecha.strftime("%d-%m-%y")
  end
  def comments_link
    "/comments?post_id=#{@object[:id]} "
  end
end
