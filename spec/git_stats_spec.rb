require 'spec_helper'
require 'open3'

describe GitStats do
  describe '.root' do
    it 'returns the project root path' do
      expect(described_class.root).to eq Pathname.new(File.expand_path('../', __dir__))
    end
  end

  describe 'gemspec sanity' do
    after do
      FileUtils.rm(Dir.glob('git_stats*.gem'))
    end

    let(:build) do
      Bundler.with_original_env do
        Open3.capture3('gem build git_stats.gemspec')
      end
    end

    it 'has no warnings' do
      expect(build[1]).not_to include('WARNING')
    end

    it 'succeeds' do
      expect(build[2]).to be_success
    end
  end
end
