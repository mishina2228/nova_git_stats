require 'spec_helper'

describe GitStats do
  describe '.root' do
    it 'returns the project root path' do
      expect(described_class.root).to eq Pathname.new(File.expand_path('../', __dir__))
    end
  end
end
