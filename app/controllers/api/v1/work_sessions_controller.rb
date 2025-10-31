module Api
  module V1
    class WorkSessionsController < ApplicationController
      before_action :set_task

      def create
        work_session = @task.work_sessions.build(work_session_params)

        if work_session.save
          render json: work_session, status: :created
        else
          render json: { errors: work_session.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        work_session = @task.work_sessions.find(params[:id])
        work_session.destroy
        head :no_content
      end

      private

      def set_task
        @task = current_user.tasks.find(params[:task_id])
      end

      def work_session_params
        params.require(:work_session).permit(:started_at, :ended_at)
      end
    end
  end
end
