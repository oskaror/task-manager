# frozen_string_literal: true

module Authentication
  extend self

  Session = Struct.new(:user_email, :token, keyword_init: true)

  delegate :create_session, to: CreateSessionService
  delegate :retrieve_user,  to: RetrieveUserService
end
