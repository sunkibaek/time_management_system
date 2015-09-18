module Api
  module V1
    class CurrentUsersController < ApiBaseController
      def show
        @user = current_user

        render status: 200
      end
    end
  end
end
