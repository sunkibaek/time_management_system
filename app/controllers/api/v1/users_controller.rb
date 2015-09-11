module Api
  module V1
    class UsersController < ApplicationController
      MSG = { success: 'User account successfully created.',
              error: 'There was an error creating the account.' }

      def create
        @user = sign_up(user_params)

        if @user.valid?
          sign_in(@user)
          flash[:notice] = MSG[:success]
        else
          render json: { notice: MSG[:error] }
        end
      end

      private

      def user_params
        params.require(:user).permit(:name, :email, :password)
      end
    end
  end
end
