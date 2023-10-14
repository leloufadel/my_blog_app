module Api
    class UsersController < ApplicationController
        before_action :authenticate_api, except: [:index]
      def index
        @users = User.all
        render json: @users
   end
  end
  end