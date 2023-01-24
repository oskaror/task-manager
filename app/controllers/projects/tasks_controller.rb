# frozen_string_literal: true

module Projects
  class TasksController < ApplicationController
    before_action :ensure_authenticated_user

    def index
      project = Project.find(params[:project_id])

      render json: TaskSerializer.new(project.tasks)
    end

    def create
      project = Project.find(params[:project_id])
      task    = project.tasks.new(task_params)

      if task.save
        render json: TaskSerializer.new(task), status: :created
      else
        render json: { errors: task.errors }, status: :unprocessable_entity
      end
    end

    def show
      task = Task.find_by!(id: params[:id], project_id: params[:project_id])

      render json: TaskSerializer.new(task)
    end

    def update
      task = Task.find_by!(id: params[:id], project_id: params[:project_id])

      if task.update(task_params)
        render json: TaskSerializer.new(task)
      else
        render json: { errors: task.errors }, status: :unprocessable_entity
      end
    end

    def destroy
      Task.find(params[:id]).destroy!
      head :ok
    end

    private

    def task_params
      params.permit(:name, :description, :user_id, :project_id)
    end
  end
end
