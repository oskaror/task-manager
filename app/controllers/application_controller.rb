# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from Errors::AuthError do |e|
    render_single_error(message: e.message, status: :unauthorized)
  end

  rescue_from ActiveRecord::RecordNotFound do
    render_single_error(message: 'Not found', status: :not_found)
  end

  private

  def render_single_error(message:, status:)
    render json: { error: message }, status: status
  end

  def current_user
    @current_user ||= Authentication.retrieve_user(token: request.headers['Authorization'])
  end

  def ensure_authenticated_user
    raise Errors::AuthError 'Authorization failed' unless current_user
  end
end
