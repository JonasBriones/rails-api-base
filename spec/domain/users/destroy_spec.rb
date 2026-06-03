# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users API: Destroy', type: :request, include_shared: true do
  describe 'DELETE /api/v1/users/:id' do
    it 'elimina el usuario y devuelve un estado 204' do
      expect do
        delete "/api/v1/users/#{user_id}", headers: headers
      end.to change(User, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end
