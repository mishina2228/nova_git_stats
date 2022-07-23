# frozen_string_literal: true

require 'spec_helper'

describe GitStats::Generator do
  describe '#initialize' do
    let(:generator) { described_class.new({path: build(:test_repo_tree).path, out_path: '.', tree_path: tree_path}) }

    context 'when tree_path is not passed' do
      let(:tree_path) { nil }

      it 'sets "." for `tree_path` as a default value' do
        repo = generator.instance_variable_get(:@repo)
        expect(repo.tree_path).to eq '.'
      end
    end

    context 'when tree_path is passed' do
      let(:tree_path) { 'subdir_with_1_commit' }

      it 'sets "subdir_with_1_commit" for `tree_path` as a default value' do
        repo = generator.instance_variable_get(:@repo)
        expect(repo.tree_path).to eq 'subdir_with_1_commit'
      end
    end
  end

  describe '#validate_repo_path' do
    let(:generator) { described_class.new({path: path, out_path: '.'}) }
    let(:valid_repo) { build(:test_repo) }

    context 'when repo path is not passed' do
      let(:path) { nil }

      it 'raises an exception' do
        expect { generator }.to raise_error('`path` is not specified')
      end
    end

    context 'when given repo path is not a git repository' do
      let(:path) { 'invalid_repo_path' }

      it 'raises an exception' do
        expect { generator }.to raise_error("'#{File.expand_path('invalid_repo_path')}' is not a git repository")
      end
    end

    context 'when given repo path is a git repository and an absolute path' do
      let(:path) { valid_repo.path }

      it 'does not raise exception' do
        expect { generator }.not_to raise_error
      end
    end

    context 'when given repo path is a git repository and a relative path including tilde' do
      let(:path) { File.join('~/../../', valid_repo.path) }

      it 'converts it to an absolute path' do
        expect(generator.path).to eq(valid_repo.path)
      end
    end
  end

  describe '#out_path' do
    let(:valid_repo) { build(:test_repo) }
    let(:generator) { described_class.new({path: valid_repo.path, out_path: out_path}) }

    context 'when out_path is not passed' do
      let(:out_path) { nil }

      it 'raises an exception' do
        expect { generator }.to raise_error(TypeError)
      end
    end

    context 'when given out_path is an absolute path' do
      let(:out_path) { '/tmp' }

      it 'returns the given out_path as is' do
        expect(generator.out_path).to eq('/tmp')
      end
    end

    context 'when given out_path is a relative path' do
      let(:out_path) { '.' }

      it 'converts it to an absolute path' do
        expect(generator.out_path).to eq(Dir.pwd)
      end
    end

    context 'when given out_path includes tilde' do
      let(:out_path) { '~/../../' }

      it 'converts it to an absolute path' do
        expect(generator.out_path).to eq('/')
      end
    end
  end
end
