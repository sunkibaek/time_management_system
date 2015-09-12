module Api
  module V1
    class TasksController < ApplicationController
      MSG = { success: 'Task successfully added.',
              index: 'Tasks list updated.' }

      def index
        tasks = if signed_in?
                  current_user.tasks.order_by_date_desc
                else
                  Task.none
                end

        render json: { tasks: tasks, notice: MSG[:index] }, status: 200
      end

      def create
        task = current_user.tasks.new(task_params)

        if task.save
          render json: { notice: MSG[:success] }, status: 200
        else
          render json: {}, status: 400
        end
      end

      private

      def task_params
        params.require(:task).permit(:description, :date, :hour)
      end
    end
  end
end
