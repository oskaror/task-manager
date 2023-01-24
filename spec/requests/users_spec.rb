# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  subject { parsed_response(response) }

  describe 'GET /users' do
    let_it_be(:current_user) { create(:user) }
    let_it_be(:user)         { create(:user) }

    def make_request
      get '/users', headers: auth_headers
    end

    it 'returns the success response' do
      make_request

      expect(response.status).to eq(200)
      expect(subject[:data].size).to eq(2)
      expect(subject[:data][0]).to eq(
        {
          id:    current_user.id,
          email: current_user.email
        }
      )
    end

    context 'when wrong authentication token' do
      it_behaves_like 'blank authentication token'
      it_behaves_like 'invalid authentication token'
    end
  end

  describe 'POST /users' do
    let(:params) do
      {
        email:    'user@example.com',
        password: 'password'
      }
    end

    def make_request
      post '/users', params: params
    end

    it 'returns the success response' do
      make_request

      expect(response.status).to eq(201)
      expect(subject).to eq(
        {
          data: {
            id:    User.last.id,
            email: 'user@example.com'
          }
        }
      )
    end

    it 'creates a new user' do
      expect { make_request }.to change(User, :count).by(1)
    end

    context 'with empty params' do
      let(:params) { {} }

      it 'returns the error response' do
        make_request

        expect(response.status).to eq(422)
        expect(subject).to eq(
          {
            errors: {
              email:    ["can't be blank", 'is invalid'],
              password: ["can't be blank"]
            }
          }
        )
      end

      it 'does not create a user' do
        expect { make_request }.not_to change(User, :count)
      end
    end

    context 'with invalid params' do
      let(:params) do
        {
          email:    'INVALID_EMAIL',
          password: 'password'
        }
      end

      it 'returns the error response' do
        make_request

        expect(response.status).to eq(422)
        expect(subject).to eq(errors: { email: ['is invalid'] })
      end

      it 'does not create a user' do
        expect { make_request }.not_to change(User, :count)
      end
    end

    context 'with the already taken email' do
      let(:params) do
        {
          email:    'user@example.com',
          password: 'password'
        }
      end

      before { create(:user, email: 'user@example.com') }

      it 'returns the error response' do
        make_request

        expect(response.status).to eq(422)
        expect(subject).to eq(errors: { email: ['has already been taken'] })
      end

      it 'does not create a user' do
        expect { make_request }.not_to change(User, :count)
      end
    end
  end
end
