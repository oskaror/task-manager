# frozen_string_literal: true

class SessionSerializer < BaseSerializer
  attributes :user_email, :token
end
