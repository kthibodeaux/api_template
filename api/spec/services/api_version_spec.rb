# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApiVersion do
  describe '.version' do
    it 'returns a string' do
      expect(described_class.version).to be_a String
    end

    it 'always returns the same value' do
      version1 = described_class.version
      version2 = described_class.version
      version3 = described_class.version

      expect(version1).to eq(version2)
      expect(version2).to eq(version3)
    end
  end
end
