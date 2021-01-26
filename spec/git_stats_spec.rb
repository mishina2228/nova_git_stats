require 'spec_helper'

describe GitStats do
  describe '.root' do
    it 'returns the project root path' do
      # I don't know how to test this method correctly...
      path = described_class.root
      expect(path.join('spec/git_stats_spec.rb').to_s).to eq __FILE__
    end
  end
end
