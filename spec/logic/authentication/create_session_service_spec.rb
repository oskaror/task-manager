# frozen_string_literal: true

require 'rails_helper'

describe Authentication::CreateSessionService do
  describe '.create_session' do
    subject { Authentication.create_session(user_email: user_email, password: password) }

    let_it_be(:user) { create(:user, email: 'user@example.com', password: 'password') }

    let(:user_email) { 'user@example.com' }
    let(:password)   { 'password' }
    let(:auth_token) { 'auth_token' }

    it 'returns the session', freezetime: true do
      expect(subject).to be_a(Authentication::Session)
      expect(JwtService.decode_token(subject.token)).to eq(
        {
          user_email: user_email,
          exp:        10.days.from_now.to_i
        }
      )
    end

    context 'when a user does not exists' do
      let(:user_email) { 'invalid_email' }

      it 'raises an error' do
        expect { subject }.to raise_error(Errors::AuthError, 'Invalid email or password')
      end
    end

    context 'with invalid password' do
      let(:password) { 'invalid' }

      it 'raises an error' do
        expect { subject }.to raise_error(Errors::AuthError, 'Invalid email or password')
      end
    end
  end
end
