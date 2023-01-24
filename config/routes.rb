# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users,    only: %i[index create]
  resources :sessions, only: %i[create]
  resources :projects, only: %i[index create show update destroy] do
    resources :tasks,  only: %i[index create show update destroy], controller: 'projects/tasks'
  end
end
