class CategorySerializer < ActiveModel::Serializer
    attributes :name_category, :link_posts
    def link_posts
        "/posts/category?page=1&id=#{self.object[:id]}"
    end
end