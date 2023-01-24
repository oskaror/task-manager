# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :ensure_authenticated_user

  def index
    projects = Project.all

    render json: ProjectSerializer.new(projects)
  end

  def create
    project = Project.new(project_params)

    if project.save
      render json: ProjectSerializer.new(project), status: :created
    else
      render json: { errors: project.errors }, status: :unprocessable_entity
    end
  end

  def show
    project = Project.find(params[:id])

    render json: ProjectSerializer.new(project)
  end

  def update
    project = Project.find(params[:id])

    if project.update(project_params)
      render json: ProjectSerializer.new(project)
    else
      render json: project.errors, status: :unprocessable_entity
    end
  end

  def destroy
    Project.find(params[:id]).destroy!
    head :ok
  end

  private

  def project_params
    params.permit(:name, :description)
  end
end
