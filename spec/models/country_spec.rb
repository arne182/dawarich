# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Country, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:iso2_code) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:cities).dependent(:destroy) }
    it { is_expected.to have_many(:states).dependent(:destroy) }
    it { is_expected.to have_many(:counties).dependent(:destroy) }
  end
end
