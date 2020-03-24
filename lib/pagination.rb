# Esta clase realizar un json con nuestros datos
# y le agregarle un header del json
# Recibe un objeto el cual es nuestros datos
# creamos un json en el cual primero se pone 
# la cabecera con los datos que se requiera.
# luego serializamos nuestros datos y lo agregamos
# a nuestro json para retornar.
class Pagination
    def self.build_json (object)
      ob_name = object.name.downcase.pluralize
      
      json = Hash.new
      json = {
        next_page: object.next_page,
        prev_page: object.prev_page,
        total_in_page: object.count
    }
      json[ob_name] = ActiveModelSerializers::SerializableResource.new(object.to_a)
      puts "nombre:#{object.to_a} "
      return json
    end
end