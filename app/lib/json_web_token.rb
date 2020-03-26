require "byebug"
class JsonWebToken
  #Es la tercer parte del JWT. El código con el que se firmará el JWT
  SECRET_KEY = Rails.application.secrets.secret_key_base. to_s

  #Codificando el payload
  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  #Decoficando el payload
  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    byebug
    HashWithIndifferentAccess.new decoded
  end
end