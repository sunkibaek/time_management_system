module Api
  module V1
    module Admin
      class UsersController < ApplicationController
        def index
          if current_user.user_manager?
            @users = User.all

            render status: 200
          else
            render json: {}, status: 403
          end
        end
      end
    end
  end
end
