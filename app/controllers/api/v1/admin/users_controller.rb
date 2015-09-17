module Api
  module V1
    module Admin
      class UsersController < ApplicationController
        MSG = {
          update: 'User account successfully updated.'
        }

        def index
          if current_user.user_manager?
            @users = User.order_by_id_desc

            render status: 200
          else
            render json: {}, status: 403
          end
        end

        def update
          if current_user.user_manager?
            user = User.find(params[:id])

            user.update(user_params)
            render json: { notice: MSG[:update] }, status: 200
          else
            render json: {}, status: 403
          end
        end

        private

        def user_params
          params.require(:user).permit(:preferred_working_hour)
        end
      end
    end
  end
end
