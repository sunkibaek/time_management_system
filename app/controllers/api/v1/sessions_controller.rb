module Api
  module V1
    class SessionsController < ApplicationController
      MSG = { success: 'Successfully logged in.',
        error: 'There was an error loggin in.',
        destroy: 'Successfully logged out.' }

      def create
        user = authenticate_session(session_params)

        if sign_in(user)
          render json: { notice: MSG[:success] }, status: 200
        else
          render json: { notice: MSG[:error] }, status: 400
        end
      end

      def destroy
        sign_out
        render json: { notice: MSG[:destroy] }, status: 200
      end

      private

      def session_params
        params.require(:session).permit(:email, :password)
      end
    end
  end
end
