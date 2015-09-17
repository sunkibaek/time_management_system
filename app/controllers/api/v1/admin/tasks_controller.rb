module Api
  module V1
    module Admin
      class TasksController < ApplicationController
        MSG = { success: 'Task successfully added.',
                update: 'Task successfully edited.',
                destroy: 'Task successfully deleted.',
                index: 'Tasks list updated.' }

        def index
          if current_user.admin?
            @tasks = Task.with_users.order_by_date_desc
            render status: 200
          else
            render json: {}, status: 403
          end
        end

        def show
          if current_user.admin?
            @task = Task.find(params[:id])
            render status: 200
          else
            render json: {}, status: 403
          end
        end

        def update
          if current_user.admin?
            task = Task.find(params[:id])
            task.update(task_params)
            render json: { notice: MSG[:update] }, status: 200
          else
            render json: {}, status: 403
          end
        end

        def destroy
          if current_user.admin?
            task = Task.find(params[:id])
            task.destroy
            render json: { notice: MSG[:destroy] }, status: 200
          else
            render json: {}, status: 403
          end
        end

        private

        def task_params
          params.require(:task).permit(:description, :date, :hour)
        end
      end
    end
  end
end
