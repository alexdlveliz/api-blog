# Mandamos solo los atributos que necesitamos del modelo
# hacemos una asociación  usuario para poder utilizarlo en nuestro
# una función para regresar la fecha de creción
class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :creation
  belongs_to :user
  def creation
    fecha = self.object[:created_at]
    fecha.strftime("%d-%m-%y")
  end
end
