# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Project Tasks API', type: :request do
  subject { parsed_response(response) }

  let_it_be(:current_user) { create(:user) }
  let_it_be(:task)         { create(:task, :with_user) }

  describe 'GET /projects/:project_id/tasks' do
    let(:project_id) { task.project.id }

    def make_request
      get "/projects/#{project_id}/tasks", headers: auth_headers
    end

    it 'returns the success response' do
      make_request

      expect(response.status).to eq(200)
      expect(subject[:data].size).to eq(1)
      expect(subject[:data][0]).to eq(
        {
          name:        task.name,
          description: task.description,
          project:     {
            id:          task.project.id,
            name:        task.project.name,
            description: task.project.description
          },
          user:        {
            id:    task.user.id,
            email: task.user.email
          }
        }
      )
    end

    context 'with not existed project' do
      let(:project_id) { 0 }

      it 'returns the success response' do
        make_request

        expect(response.status).to eq(404)
        expect(subject).to eq(error: 'Not found')
      end
    end

    context 'when wrong authentication token' do
      it_behaves_like 'blank authentication token'
      it_behaves_like 'invalid authentication token'
    end
  end

  describe 'POST /projects/:project_id/tasks' do
    let_it_be(:project) { create(:project) }

    let(:params) do
      {
        name:        'Task name',
        description: 'Task description',
        user_id:     current_user.id
      }
    end

    def make_request
      post "/projects/#{project.id}/tasks", params: params.to_json, headers: auth_headers
    end

    it 'returns the success response' do
      make_request

      expect(response.status).to eq(201)
      expect(subject[:data]).to eq(
        {
          name:        params[:name],
          description: params[:description],
          project:     {
            id:          project.id,
            name:        project.name,
            description: project.description
          },
          user:        {
            id:    current_user.id,
            email: current_user.email
          }
        }
      )
    end

    it 'creates a new task' do
      expect { make_request }.to change(Task, :count).by(1)
    end

    context 'with empty params' do
      let(:params) { {} }

      it 'returns the error response' do
        make_request

        expect(response.status).to eq(422)
        expect(subject).to eq(errors: { name: ["can't be blank"] })
      end
    end

    context 'when wrong authentication token' do
      it_behaves_like 'blank authentication token'
      it_behaves_like 'invalid authentication token'
    end
  end

  describe 'GET /projects/:project_id/tasks/:id' do
    let(:project_id) { task.project.id }

    def make_request
      get "/projects/#{project_id}/tasks/#{task.id}", headers: auth_headers
    end

    it 'returns the success response' do
      make_request

      expect(response.status).to eq(200)
      expect(subject[:data]).to eq(
        {
          name:        task.name,
          description: task.description,
          project:     {
            id:          task.project.id,
            name:        task.project.name,
            description: task.project.description
          },
          user:        {
            id:    task.user.id,
            email: task.user.email
          }
        }
      )
    end

    context 'when wrong authentication token' do
      it_behaves_like 'blank authentication token'
      it_behaves_like 'invalid authentication token'
    end
  end

  describe 'UPDATE /projects/:project_id/tasks/:id' do
    let(:project_id) { task.project.id }

    let(:params) do
      {
        name:        'New project name',
        description: 'New project description'
      }
    end

    def make_request
      patch "/projects/#{project_id}/tasks/#{task.id}", params: params.to_json, headers: auth_headers
    end

    it 'returns the success response' do
      make_request

      expect(response.status).to eq(200)
      expect(subject[:data]).to eq(
        {
          name:        params[:name],
          description: params[:description],
          project:     {
            id:          task.project.id,
            name:        task.project.name,
            description: task.project.description
          },
          user:        {
            id:    task.user.id,
            email: task.user.email
          }
        }
      )
    end

    it 'updates the project' do
      expect { make_request }.to(change { task.reload.attributes })
    end

    context 'when wrong authentication token' do
      it_behaves_like 'blank authentication token'
      it_behaves_like 'invalid authentication token'
    end
  end

  describe 'DELETE /projects/:project_id/tasks/:id' do
    let(:project_id) { task.project.id }

    def make_request
      delete "/projects/#{project_id}/tasks/#{task.id}", headers: auth_headers
    end

    it 'returns the success response' do
      make_request

      expect(response.status).to eq(200)
    end

    it 'deletes a task' do
      expect { make_request }.to change(Task, :count).by(-1)
    end

    context 'when wrong authentication token' do
      it_behaves_like 'blank authentication token'
      it_behaves_like 'invalid authentication token'
    end
  end
end
