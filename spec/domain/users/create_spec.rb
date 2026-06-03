# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users API: Create', type: :request do
  describe 'POST /api/v1/users' do
    context 'con parámetros válidos' do
      let(:valid_attributes) { attributes_for(:user, password: 'password123', password_confirmation: 'password123') }

      it 'crea un nuevo usuario y devuelve un estado 201' do
        expect do
          post '/api/v1/users', params: { user: valid_attributes }
        end.to change(User, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end
  end
end
