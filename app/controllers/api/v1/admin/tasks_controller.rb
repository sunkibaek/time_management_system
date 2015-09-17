module Api
  module V1
    module Admin
      class TasksController < ApplicationController
        def index
          if current_user.admin?
            @tasks = Task.with_users.order_by_date_desc
            render status: 200
          else
            render json: {}, status: 403
          end
        end
      end
    end
  end
end
