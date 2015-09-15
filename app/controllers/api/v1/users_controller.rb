module Api
  module V1
    class UsersController < ApplicationController
      MSG = { success: 'User account successfully created.',
              update: 'User account successfully updated.',
              error: 'There was an error processing it.' }

      def create
        @user = sign_up(user_params)

        if @user.valid?
          sign_in(@user)
          flash[:notice] = MSG[:success]
        else
          render json: { notice: MSG[:error] }, status: 400
        end
      end

      def update
        if current_user.update(preferred_working_hour_param)
          render json: { notice: MSG[:update] }, status: 200
        else
          render json: { notice: MSG[:error] }, status: 400
        end
      end

      def me
        if signed_in?
          render json:
            { name: current_user.name,
              preferred_working_hour: current_user.preferred_working_hour
            }, status: 200
        else
          render json: {}, status: 200
        end
      end

      private

      def user_params
        params.require(:user).permit(:name, :email, :password)
      end

      def preferred_working_hour_param
        params.require(:user).permit(:preferred_working_hour)
      end
    end
  end
end
