# frozen_string_literal: true

require 'rails_helper'

describe Authentication::RetrieveUserService do
  describe '.create_session' do
    subject { Authentication.retrieve_user(token: token) }

    let_it_be(:user) { create(:user, email: 'user@example.com', password: 'password') }

    let(:token) do
      JwtService.encode_token(user_email: 'user@example.com', exp: 10.days.from_now.to_i)
    end

    it 'returns the user' do
      expect(subject).to eq(user)
    end

    context 'when a user does not exists' do
      let(:token) do
        JwtService.encode_token(user_email: 'invalid_user@example.com', exp: 10.days.from_now.to_i)
      end

      it 'return the nil value' do
        expect(subject).to be_nil
      end
    end

    context 'with expired token' do
      let(:token) do
        JwtService.encode_token(user_email: 'user@example.com', exp: 2.days.ago.to_i)
      end

      it 'raises the auth error' do
        expect { subject }.to raise_error(Errors::AuthError, 'Authorization failed')
      end
    end

    context 'with invalid_token token' do
      let(:token) { 'invalid_token' }

      it 'raises the auth error' do
        expect { subject }.to raise_error(Errors::AuthError, 'Authorization failed')
      end
    end
  end
end
