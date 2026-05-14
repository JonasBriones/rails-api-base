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

      def create
        @user = User.new(user_params)

        if @user.save
          render json: @user, except: [:password_digest], status: :created
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_content
        end
      end

      def update
        if @user.update(update_params)
          render json: @user, except: [:password_digest], status: :ok
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_content
        end
      end

      def destroy
        @user.destroy
        head :no_content
      end

      private

      def user_params
        params.expect(user: %i[fullName email dni password password_confirmation])
      end

      def update_params
        params.expect(user: %i[fullName dni password])
      end

      def set_user
        @user = User.find(params.expect(:id))
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'User not found' }, status: :not_found
      end
    end
  end
end
