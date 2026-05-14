# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users API: Index', type: :request, include_shared: true do
  describe 'GET /api/v1/users' do
    let!(:other_user) { create(:user) }

    it 'devuelve una lista de todos los usuarios y un estado 200' do
      get '/api/v1/users', headers: headers
      expect(response).to have_http_status(:ok)
      expect(json.size).to eq(2)
    end
  end
end
