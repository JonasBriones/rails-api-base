# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorize_request, except: :create
      before_action :set_user, only: %i[show update destroy]
      def index
        @users = User.all
        render json: @users, except: [:password_digest], status: :ok
      end

      def show
        render json: @user, except: [:password_digest], status: :ok
      end

      def update; end

      def destroy; end

      def create
        @user = User.new(user_params)

        if @user.save
          render json: @user, except: [:password_digest], status: :created
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:fullName, :email, :dni, :password, :password_confirmation)
      end

      def set_user
        @user = User.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'User not found' }, status: :not_found
      end
    end
  end
end
