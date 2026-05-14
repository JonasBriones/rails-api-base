# frozen_string_literal: true

class AuthenticationService
  # Este método será el punto de entrada
  def self.login(email, password)
    user = User.find_by(email: email)

    if user&.authenticate(password)
      # Si la autenticación es exitosa, devolvemos los datos del payload
      { success: true, payload: build_success_payload(user) }
    else
      # Si falla, devolvemos un estado de fallo
      { success: false, error: 'unauthorized' }
    end
  end

  def self.build_success_payload(user)
    token = JsonWebToken.encode(user_id: user.id)
    time = Time.zone.now + 24.hours.to_i

    {
      token: token,
      user: user.as_json(only: %i[id email created_at]),
      exp: time.strftime('%m-%d-%Y %H:%M')
    }
  end
end
