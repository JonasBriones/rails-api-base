# frozen_string_literal: true

module Api
  module V1
    class AuthController < ApplicationController
      def login
        user = User.find_by(email: params[:email])
        if user&.authenticate(params[:password])
          token = JsonWebToken.encode(user_id: user.id)
          time = Time.zone.now + 24.hours.to_i
          render json: {
            token: token, user: user.as_json(only: %i[id email
                                                      created_at]), exp: time.strftime('%m-%d-%Y %H:%M')
          }, status: :ok
        else
          render json: { error: 'unauthorized' }, status: :unauthorized
        end
      end
    end
  end
end
