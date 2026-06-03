# spec/requests/api/v1/users/index_spec.rb
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users API: Index', type: :request do
  # Aquí redefinimos el 'user' de la shared_context para que sea un 'admin'
  # Este 'user' será el que se use para generar los 'headers' de autenticación.
  let!(:user) { create(:user, :admin) } # <--- ¡CAMBIO AQUÍ! Crea un usuario admin

  # Este 'other_user' será solo otro usuario en la base de datos para listar.
  let!(:other_user) { create(:user) }

  describe 'GET /api/v1/users' do
    # Este 'let(:headers)' proviene de la shared_context y usará el 'user' (ahora admin)
    let(:headers) { { 'Authorization' => "Bearer #{JsonWebToken.encode(user_id: user.id)}" } }

    it 'devuelve una lista de todos los usuarios y un estado 200' do
      get '/api/v1/users', headers: headers
      expect(response).to have_http_status(:ok)
      expect(json.size).to eq(2)

      expect(json.first['password_digest']).to be_nil
    end
  end
end
