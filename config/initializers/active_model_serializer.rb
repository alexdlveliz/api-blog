# Configuro el adaptador para enviar un json
# Configuro lo que esté incluira, le deje vacío para que no me incluya
# ni una asociación, esto para que nosotros tengamos un mejor manejo 
# de las asiciaciones que queremos incluir, en el controlador
# ejemplo comments_controller.rb
# consultamos nuestra información, y le aplicamos
# render json: @comments, status: :ok, include: ['user']
# con eso de include asociamos la información que tiene el usuario.
ActiveModelSerializers.config.adapter = :json
ActiveModel::Serializer.config.default_includes = '' 


