# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project do
  subject { build(:project) }

  describe 'associations' do
    it { is_expected.to have_many(:tasks).dependent(:destroy_async) }
  end

  describe 'validations' do
    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:name) }
  end
end
