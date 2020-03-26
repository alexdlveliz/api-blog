class ApplicationController < ActionController::API
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
end
