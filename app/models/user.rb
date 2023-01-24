# frozen_string_literal: true

class User < ApplicationRecord
  has_many :tasks, dependent: :nullify

  has_secure_password

  validates :email, presence:   true,
                    uniqueness: { case_sensitive: false },
                    format:     { with: URI::MailTo::EMAIL_REGEXP }
end
