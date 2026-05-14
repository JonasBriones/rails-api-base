# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Creation and manage Users', type: :request do
  describe 'POST /api/v1/users' do
    context 'cuando la petición es válida (parámetros correctos)' do
      let(:valid_attributes) do
        attributes_for(:user).merge({
          password: 'password123',
          password_confirmation: 'password123'
        })
      end

      it 'crea un nuevo usuario' do
        post '/api/v1/users', params: { user: valid_attributes }
        
        unless response.status == 201
          # Esta línea es oro: imprimirá los errores JSON si la prueba falla.
          puts "Falló la creación del usuario. Errores: #{response.body}" 
        end
        expect(response).to have_http_status(201)
        expect(json['email']).to eq(valid_attributes[:email])

      end
    end
  end

  describe 'GET /api/v1/users' do
    let!(:user) { create(:user) }
    let(:user_id) { user.id }
    before { get '/api/v1/users' }

    it 'returns users' do
      expect(json).not_to be_empty
      expect(json.size).to eq(1)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'does not return the password_digest' do
      expect(json.first['password_digest']).to be_nil
    end
  end

  # Reemplaza el bloque completo en users_spec.rb

  # --- Pruebas para GET /api/v1/users/:id (show) ---
  describe 'GET /api/v1/users/:id' do
    let!(:user) { create(:user) }
    let(:user_id) { user.id }
    context 'cuando el usuario existe y la petición es válida' do
      before { get "/api/v1/users/#{user_id}", headers: headers }

      it 'devuelve un código de estado 200 y el usuario correcto' do
        expect(response).to have_http_status(200)
        expect(json).not_to be_nil
        expect(json['id']).to eq(user_id)
        expect(json['email']).to eq(user.email)
      end
      
      it 'no devuelve el password_digest' do
        expect(response).to have_http_status(200)
        expect(json['password_digest']).to be_nil
      end
    end

    context 'cuando el usuario no existe' do
      let(:non_existent_user_id) { 0 } # Un ID que probablemente no existe
      before { get "/api/v1/users/#{non_existent_user_id}", headers: headers }
      it 'devuelve un código de estado 404' do
        expect(response).to have_http_status(404)
      end
      
      it 'devuelve un mensaje de error' do
        expect(json['error']).to eq('User not found')
      end
    end
  end

  #Borramos el usuario
  describe 'PUT /api/v1/users/:id' do 
    context 'editamos el nombre del usuario y validamos que es correcto el cambio' do 
      before { get "/api/v1/users/#{user_id}", headers: headers }
    end
  end

  #Borramos el usuario
  describe 'DELETE /api/v1/users/:id' do 
    context 'borramos un usuario existente' do 
      before { get "/api/v1/users/#{user_id}", headers: headers }
      it 'devuelve ok s'
    end
  end
end
