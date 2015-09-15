module Api
  module V1
    class TasksController < ApplicationController
      MSG = { success: 'Task successfully added.',
              update: 'Task successfully edited.',
              destroy: 'Task successfully deleted.',
              index: 'Tasks list updated.' }

      def index
        @tasks = if signed_in?
                   current_user.tasks.order_by_date_desc
                 else
                   Task.none
                 end
        flash[:notice] = MSG[:index]
        render status: 200
      end

      def show
        @task = if signed_in?
                  current_user.tasks.find(params[:id])
                else
                  Task.none
                end

        render status: 200
      end

      def create
        task = current_user.tasks.new(task_params)

        if task.save
          render json: { notice: MSG[:success] }, status: 200
        else
          render json: {}, status: 400
        end
      end

      def update
        task = current_user.tasks.find(params[:id])

        if task.update(task_params)
          render json: { notice: MSG[:update] }, status: 200
        else
          render json: {}, status: 400
        end
      end

      def destroy
        task = current_user.tasks.find(params[:id])

        if task.destroy
          render json: { notice: MSG[:destroy] }, status: 200
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
