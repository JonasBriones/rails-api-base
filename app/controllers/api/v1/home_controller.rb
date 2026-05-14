# frozen_string_literal: true

module Api
  module V1
    class HomeController < ApplicationController
      def index
        render json: {
          name: 'Base API DDD',
          version: '1.0.0',
          status: 'online',
          documentation: {
            endpoints: {
              health: {
                method: 'GET', path: '/api/v1/health', description: 'System health check'
              }
            }
          },
          timestamp: Time.current.iso8601
        }
      end

      def health_check
        health_status = HealthCheck::Checker.call

        status_code = health_status[:healthy] ? :ok : :service_unavailable

        render json: health_status, status: status_code
      end
    end
  end
end
