module Api
  module V1
    class SessionsController < ApiBaseController
      skip_before_action :authorize, only: [:create]

      MSG = { success: 'Successfully logged in.',
        error: 'There was an error loggin in.',
        destroy: 'Successfully logged out.' }

      def create
        user = authenticate(
          User.find_by(email: session_params[:email]),
          session_params[:password])

        if user
          render json: { auth_token: user.auth_token, notice: MSG[:success] }, status: 200
        else
          render json: { notice: MSG[:error] }, status: 400
        end
      end

      private

      def session_params
        params.require(:session).permit(:email, :password)
      end
    end
  end
end
