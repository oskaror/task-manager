# frozen_string_literal: true

module Authentication
  class CreateSessionService
    include Helpers::TokensHelper

    def self.create_session(args)
      new(**args).call
    end

    def initialize(user_email:, password:)
      @user_email = user_email
      @password   = password
    end

    def call
      return raise_auth_error unless account&.authenticate(password)

      Session.new(
        user_email: user_email,
        token:      encode_session_token(user_email: user_email)
      )
    end

    private

    attr_reader :user_email, :password

    def raise_auth_error
      raise Errors::AuthError, 'Invalid email or password'
    end

    def account
      @account ||= User.find_by(email: user_email)
    end
  end
end
