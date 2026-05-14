# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users API: Update', type: :request, include_shared: true do
  describe 'PUT /api/v1/users/:id' do
    let(:update_params) { { user: { fullName: 'Nombre Actualizado' } } }

    it 'actualiza el usuario y devuelve un estado 200' do
      put "/api/v1/users/#{user_id}", params: update_params, headers: headers
      expect(response).to have_http_status(:ok)
      expect(json['fullName']).to eq('Nombre Actualizado')
    end
  end
end
