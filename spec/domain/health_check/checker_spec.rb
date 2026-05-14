# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HealthCheck::Checker do
  describe 'GET /api/v1', type: :request do
    let(:result) { described_class.call }
    it 'returns index check results' do
      get '/api/v1/'
      puts response.status
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /api/v1/health', type: :request do
    let(:result) { described_class.call }
    it 'returns health status' do
      get '/api/v1/health'
      expect(response.status).to eq(200)
      expect(response.parsed_body['healthy']).to eq(true)
    end
  end
end
