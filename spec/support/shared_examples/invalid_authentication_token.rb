# frozen_string_literal: true

RSpec.shared_examples 'invalid authentication token' do
  describe '-' do
    let(:auth_token) { 'invalid' }

    it 'returns auth error response' do
      make_request

      expect(response.status).to eq 401
      expect(subject).to eq(error: 'Authorization failed')
    end
  end
end
