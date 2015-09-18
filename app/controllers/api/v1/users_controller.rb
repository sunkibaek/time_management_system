module Api
  module V1
    class UsersController < ApiBaseController
      skip_before_action :authorize, only: [:create]

      MSG = { success: 'User account successfully created.',
              update: 'User account successfully updated.',
              error: 'There was an error processing it.' }

      def create
        user = sign_up(user_params)

        if user.valid?
          render json: { auth_token: user.auth_token, notice: MSG[:success] }
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
