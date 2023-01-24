# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Projects API', type: :request do
  subject { parsed_response(response) }

  let_it_be(:current_user) { create(:user) }
  let_it_be(:project)      { create(:project) }

  describe 'GET /projects' do
    def make_request
      get '/projects', headers: auth_headers
    end

    it 'returns the success response' do
      make_request

      expect(response.status).to eq(200)
      expect(subject[:data].size).to eq(1)
      expect(subject[:data][0]).to eq(
        {
          id:          project.id,
          name:        project.name,
          description: project.description
        }
      )
    end

    context 'when wrong authentication token' do
      it_behaves_like 'blank authentication token'
      it_behaves_like 'invalid authentication token'
    end
  end

  describe 'POST /projects' do
    let(:params) do
      {
        name:        'Project name',
        description: 'Project description'
      }
    end

    def make_request
      post '/projects', params: params.to_json, headers: auth_headers
    end

    it 'returns the success response' do
      make_request

      expect(response.status).to eq(201)
      expect(subject[:data]).to eq(
        {
          id:          Project.last.id,
          name:        params[:name],
          description: params[:description]
        }
      )
    end

    it 'creates a new project' do
      expect { make_request }.to change(Project, :count).by(1)
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

  describe 'GET /projects/:id' do
    let(:project_id) { project.id }

    def make_request
      get "/projects/#{project_id}", headers: auth_headers
    end

    it 'returns the success response' do
      make_request

      expect(response.status).to eq(200)
      expect(subject[:data]).to eq(
        {
          id:          project.id,
          name:        project.name,
          description: project.description
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

  describe 'UPDATE /projects/:id' do
    let(:project_id) { project.id }

    let(:params) do
      {
        name:        'New project name',
        description: 'New project description'
      }
    end

    def make_request
      patch "/projects/#{project_id}", params: params.to_json, headers: auth_headers
    end

    it 'returns the success response' do
      make_request

      expect(response.status).to eq(200)
      expect(subject[:data]).to eq(
        {
          id:          project_id,
          name:        params[:name],
          description: params[:description]
        }
      )
    end

    it 'updates the project' do
      expect { make_request }.to(change { project.reload.attributes })
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

  describe 'DELETE /projects/:id' do
    let(:project_id) { project.id }

    def make_request
      delete "/projects/#{project_id}", headers: auth_headers
    end

    it 'returns the success response' do
      make_request

      expect(response.status).to eq(200)
    end

    it 'deletes a project' do
      expect { make_request }.to change(Project, :count).by(-1)
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
end
