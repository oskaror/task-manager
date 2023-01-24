# frozen_string_literal: true

module Authentication
  class RetrieveUserService
    include Helpers::TokensHelper

    def self.retrieve_user(args)
      new(**args).call
    end

    def initialize(token:)
      @token = token
    end

    def call
      email = decode_session_token(token)[:user_email]
      User.find_by(email: email)
    end

    private

    attr_reader :token
  end
end
