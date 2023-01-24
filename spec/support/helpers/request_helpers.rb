# frozen_string_literal: true

module Helpers
  module RequestHelpers
    def parsed_response(response)
      Oj.load(response.body)&.deep_symbolize_keys
    end

    def auth_headers
      { 'Authorization' => auth_token, 'Content-Type' => 'application/json' }
    end

    def auth_token
      JwtService.encode_token(user_email: current_user.email, exp: 10.days.from_now.to_i)
    end

    def current_user
      @current_user ||= create(:user)
    end
  end
end
