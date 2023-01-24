# frozen_string_literal: true

class SessionsController < ApplicationController
  def create
    session = Authentication.create_session(
      user_email: params[:email],
      password:   params[:password]
    )

    render json: SessionSerializer.new(session), status: :created
  end
end
