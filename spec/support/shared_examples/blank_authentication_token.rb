# frozen_string_literal: true

RSpec.shared_examples 'blank authentication token' do
  describe '-' do
    let(:auth_headers) { {} }

    it 'returns auth error response' do
      make_request

      expect(response.status).to eq 401
      expect(subject).to eq(error: 'Authorization failed')
    end
  end
end
