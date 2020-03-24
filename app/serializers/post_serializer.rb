require "byebug"
class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :published, :creation
  belongs_to :user
  def creation
    fecha = self.object[:created_at]
    fecha.strftime("%d-%m-%y")
  end
end
