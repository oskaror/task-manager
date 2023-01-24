# frozen_string_literal: true

module Authentication
  module Helpers
    module TokensHelper
      def encode_session_token(user_email:, expires_at: 10.days.from_now)
        JwtService.encode_token(user_email: user_email, exp: expires_at.to_i)
      end

      def decode_session_token(token)
        JwtService.decode_token(token)
      end
    end
  end
end
