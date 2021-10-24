require 'spec_helper'

describe GitStats::Generator do
  describe '#validate_repo_path' do
    let(:valid_repo) { build(:test_repo) }

    context 'when no given repo path is passed' do
      let(:generator) { described_class.new({}) }

      it 'raises exception' do
        expect { generator }.to raise_error('`path` is not specified')
      end
    end

    context 'when given repo path is not a git repository' do
      let(:generator) { described_class.new(path: 'invalid_repo_path') }

      it 'raises exception' do
        expect { generator }.to raise_error("'#{File.expand_path('invalid_repo_path')}' is not a git repository")
      end
    end

    context 'when given repo path is a git repository' do
      let(:generator) { described_class.new(path: valid_repo.path) }

      it 'does not raise exception' do
        expect { generator }.not_to raise_error
      end
    end

    context 'when given repo path is a git repository and includes tilde' do
      let(:generator) { described_class.new(path: File.join('~/../../', valid_repo.path)) }

      it 'converts it to an absolute path' do
        expect(generator.path).to eq(valid_repo.path)
      end
    end
  end
end
