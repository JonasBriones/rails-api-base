# frozen_string_literal: true

module Api
  module V1
    class AuthController < ApplicationController
      def login
        # 1. Delegamos TODO el trabajo pesado al servicio
        result = AuthenticationService.login(params[:email], params[:password])

        # 2. El controlador solo se preocupa de renderizar basado en el resultado
        if result[:success]
          render json: result[:payload], status: :ok
        else
          render json: { error: result[:error] }, status: :unauthorized
        end
      end
    end
  end
end
