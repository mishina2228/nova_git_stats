require 'spec_helper'

describe GitStats::GitData::Repo do
  let(:repo) { build(:repo) }

  describe 'commit range' do
    it 'returns HEAD by default' do
      expect(repo.commit_range).to eq('HEAD')
    end

    it 'returns last_commit if it was given' do
      repo = build(:repo, last_commit_sha: 'abc')
      expect(repo.commit_range).to eq('abc')
    end

    it 'returns range from first_commit to HEAD if first_commit was given' do
      repo = build(:repo, first_commit_sha: 'abc')
      expect(repo.commit_range).to eq('abc..HEAD')
    end

    it 'returns range from first to last commit if both were given' do
      repo = build(:repo, first_commit_sha: 'abc', last_commit_sha: 'def')
      expect(repo.commit_range).to eq('abc..def')
    end

    context 'git commands using range' do
      let(:repo) { build(:repo, first_commit_sha: 'abc', last_commit_sha: 'def') }

      it 'affects authors command' do
        expect(repo).to receive(:run).with('git shortlog -se abc..def .').and_return('')
        repo.authors
      end

      it 'affects commits command' do
        expect(repo).to receive(:run).with("git rev-list --pretty=format:'%H|%at|%ai|%aE' abc..def . | grep -v commit").and_return('')
        repo.commits
      end

      it 'affects project version command' do
        expect(repo).to receive(:run).with('git rev-parse abc..def').and_return('')
        repo.project_version
      end
    end
  end
end
