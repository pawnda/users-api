module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user

      # GET /users
      def index
        @users = User.all

        render json: @users
      end

      private

      def user_params
        params.require(:user).permit(:phone_number, :password, :password_confirmation)
      end
    end
  end
end