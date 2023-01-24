# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  subject { build(:user) }

  describe 'associations' do
    it { is_expected.to have_many(:tasks).dependent(:nullify) }
  end

  describe 'concerns' do
    it { is_expected.to have_secure_password }
  end

  describe 'validations' do
    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }

    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

    it 'validates the email format' do
      subject.email = 'INVALID_EMAIL'
      expect(subject).not_to be_valid
    end
  end
end
