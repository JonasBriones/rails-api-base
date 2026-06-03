# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorize_request, except: :create
      before_action :set_user, only: %i[show update destroy]

      def index
        authorize User
        @users = User.all
        render json: @users, except: [:password_digest], status: :ok
      end

      def show
        authorize @user
        render json: @user, except: [:password_digest], status: :ok
      end

      def create
        @user = User.new(user_params)
        authorize @user
        
        if @user.save
          render json: @user, except: [:password_digest], status: :created
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_content
        end
      end

      def update
        authorize @user
        if @user.update(update_params)
          render json: @user, except: [:password_digest], status: :ok
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_content
        end
      end

      def destroy
        authorize @user
        @user.destroy
        head :no_content
      end

      private
      
      def user_params
        params.require(:user).permit(:fullName, :email, :dni, :date_of_birth, :password, :password_confirmation)
      end

      def update_params
        params.require(:user).permit(:fullName, :dni, :password, :role, :date_of_birth)
      end

      def set_user
        @user = User.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'User not found' }, status: :not_found
      end

    end
  end
end
