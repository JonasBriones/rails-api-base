# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Login and verification for users', type: :request do
  let!(:user) { create(:user, password: 'password123', password_confirmation: 'password123') }

  describe 'POST /api/v1/auth/login' do
    context 'cuando las credenciales son válidas' do
      let(:valid_credentials) { { email: user.email, password: 'password123' } }

      before { post '/api/v1/auth/login', params: valid_credentials }

      it 'devuelve un código de estado 200 (OK)' do
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
