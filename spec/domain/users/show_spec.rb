# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users API: Show', type: :request, include_shared: true do
  describe 'GET /api/v1/users/:id' do
    context 'cuando el usuario existe' do
      it 'devuelve el usuario y un estado 200' do
        get "/api/v1/users/#{user_id}", headers: headers
        expect(response).to have_http_status(:ok)
        expect(json['id']).to eq(user_id)
      end
    end
  end
end
