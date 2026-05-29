# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Pundit::Authorization
  
  def authorize_request
    header = request.headers['Authorization']
    token = header.split.last if header

    begin
      @decoded = JsonWebToken.decode(token)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound, JWT::DecodeError => e
      render json: { errors: [e.message] }, status: :unauthorized
    end
  end

  
  def current_user
    @current_user
  end

end
