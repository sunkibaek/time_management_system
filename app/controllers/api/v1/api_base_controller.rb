module Api
  module V1
    class ApiBaseController < ApplicationController
      attr_reader :current_user

      before_action :authorize
      respond_to :json

      # def current_user
      #   if signed_in?
      #     super
      #   else
      #     @current_user
      #   end
      # end

      def authorize
        unless signed_in?
          authenticate_token || render_unauthorized
        end
      end

      def authenticate_token
        authenticate_or_request_with_http_token do |token, _options|
          @current_user = User.find_by(auth_token: token)
        end
      end

      def render_unauthorized
        render json: { notice: 'Bad credentials' }, status: 401
      end
    end
  end
end
