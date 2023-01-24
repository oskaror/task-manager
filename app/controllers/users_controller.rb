# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :ensure_authenticated_user, only: :index

  def index
    users = User.all
    render json: UserSerializer.new(users)
  end

  def create
    user = User.new(user_params)

    if user.save
      render json: UserSerializer.new(user), status: :created
    else
      render json: { errors: user.errors }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
