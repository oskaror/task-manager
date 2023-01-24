# frozen_string_literal: true

module Errors
  BaseError = Class.new(StandardError)
  AuthError = Class.new(BaseError)
end
