# frozen_string_literal: true

class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy_async

  validates :name, presence: true
end
