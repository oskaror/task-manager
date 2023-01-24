# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions API', type: :request do
  subject { parsed_response(response) }

  describe 'POST /sessions', freezetime: true do
    let_it_be(:user) { create(:user, email: 'user@example.com', password: 'password') }

    let(:params) do
      {
        email:    'user@example.com',
        password: 'password'
      }
    end

    let(:expected_token) do
      JwtService.encode_token(user_email: user.email, exp: 10.days.from_now.to_i)
    end

    def make_request
      post '/sessions', params: params
    end

    it 'returns the success response' do
      make_request

      expect(response.status).to eq(201)
      expect(subject).to eq(
        {
          data: {
            token:      expected_token,
            user_email: 'user@example.com'
          }
        }
      )
    end

    context 'with empty params' do
      let(:params) { {} }

      it 'returns the error response' do
        make_request

        expect(response.status).to eq(401)
        expect(subject).to eq(error: 'Invalid email or password')
      end
    end

    context 'with not existing email' do
      let(:params) do
        {
          email:    'admin@example.com',
          password: 'password'
        }
      end

      it 'returns the error response' do
        make_request

        expect(response.status).to eq(401)
        expect(subject).to eq(error: 'Invalid email or password')
      end
    end
  end
end
