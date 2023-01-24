# frozen_string_literal: true

class JwtService
  INVALID_AUTH_MESSAGE = 'Authorization failed'

  def self.encode_token(payload)
    new.encode_token(**payload)
  end

  def self.decode_token(token)
    new.decode_token(token)
  end

  def encode_token(payload)
    JWT.encode(payload.compact, secret_key)
  end

  def decode_token(token)
    JWT.decode(token, secret_key).first.symbolize_keys
  rescue JWT::DecodeError
    raise Errors::AuthError, INVALID_AUTH_MESSAGE
  end

  private

  def secret_key
    Rails.application.credentials.secret_key_base
  end
end
