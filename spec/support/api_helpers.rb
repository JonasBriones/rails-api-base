# spec/support/api_helpers.rb
# frozen_string_literal: true

# Contexto compartido para pruebas que requieren un usuario autenticado.
RSpec.shared_context 'con un usuario autenticado' do
  let!(:user) { create(:user) }
  let(:user_id) { user.id }
  let(:headers) { { 'Authorization' => "Bearer #{JsonWebToken.encode(user_id: user.id)}" } }
end

# Incluir este helper para que el método 'json' esté disponible en todas las pruebas de request.
module RequestSpecHelper
  def json
    return {} if response.body.blank?

    JSON.parse(response.body)
  end
end

RSpec.configure do |config|
  config.include RequestSpecHelper, type: :request
  # Incluir el contexto compartido automáticamente en las pruebas que lo necesiten
  config.include_context 'con un usuario autenticado', include_shared: true
end
