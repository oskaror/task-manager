# frozen_string_literal: true

class TaskSerializer < BaseSerializer
  attributes :name, :description

  one :user,    resource: UserSerializer
  one :project, resource: ProjectSerializer
end
