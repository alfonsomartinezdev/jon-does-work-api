module Api
  module V1
    class TasksController < ApplicationController
      before_action :set_task, only: [ :update, :destroy ]

      def index
        tasks = current_user.tasks.includes(:work_sessions, :activities)

        render json: tasks.map { |task| task_summary(task) }
      end

      def create
        task = current_user.tasks.build(task_params)

        if task.save
          render json: task, status: :created
        else
          render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @task.update(task_params)
          # Replace activities if provided
          if params[:task][:activities].present?
            @task.activities.destroy_all
            params[:task][:activities].each do |activity_params|
              @task.activities.create(
                text: activity_params[:text],
                timestamp: activity_params[:timestamp]
              )
            end
          end

          render json: task_with_nested_data(@task)
        else
          render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @task.destroy
        head :no_content
      end

      private

      def set_task
        @task = current_user.tasks.find(params[:id])
      end

      def task_params
        params.require(:task).permit(:name, :description, :status, :assigned_date)
      end

      def task_summary(task)
        {
          id: task.id,
          name: task.name,
          description: task.description,
          status: task.status,
          assigned_date: task.assigned_date,
          total_duration: task.work_sessions.sum(:duration),
          session_count: task.work_sessions.count,
          activity_count: task.activities.count,
          created_at: task.created_at,
          updated_at: task.updated_at
        }
      end

      def task_with_nested_data(task)
        {
          id: task.id,
          name: task.name,
          description: task.description,
          status: task.status,
          assigned_date: task.assigned_date,
          work_sessions: task.work_sessions.order(started_at: :desc),
          activities: task.activities.order(timestamp: :desc),
          created_at: task.created_at,
          updated_at: task.updated_at
        }
      end
    end
  end
end
