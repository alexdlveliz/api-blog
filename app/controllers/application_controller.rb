class ApplicationController < ActionController::API
  include Pundit
  def not_found
    render json: { error: 'not_found' }
  end

  #Función encargada de autorizar las peticiones del usuario
  def authorize_request
    #Se toma el token del request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      #Se decodifica el token con la firma
      @decoded = JsonWebToken.decode(header)
      #Se verifica que el usuario exista
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
  # Acá estructuro la información de la páginas que se esten enviando,
  # lo llamo con meta: pagination en los controladores que necesite.
  def pagination (object)
    if object.next_page != nil
      string_next = "localhost:3000/posts?page=#{object.next_page}"
    end
    if object.prev_page != nil
      string_prev = "localhost:3000/posts?page=#{object.prev_page}"
    end
    meta={
      next_page: string_next,
      prev_page: string_prev,
      total_in_page: object.count
    }
    return meta
  end
end
