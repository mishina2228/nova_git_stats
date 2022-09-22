# frozen_string_literal: true

require 'spec_helper'

describe GitStats::GitData::Tree do
  let(:repo) { build(:test_repo_tree, tree_path: '.') }
  let(:repo_tree) { build(:test_repo_tree, tree_path: './subdir_with_1_commit') }
  let(:tree) { build(:tree, repo: repo_tree, relative_path: './subdir_with_1_commit') }

  describe 'tree git output parsing' do
    it 'returns . by default' do
      expect(repo.tree).to eq(described_class.new(repo: repo, relative_path: '.'))
    end

    it 'returns relative_path given by parameter' do
      expect(repo_tree.tree).to eq(described_class.new(repo: repo, relative_path: './subdir_with_1_commit'))
      expect(repo_tree.tree.relative_path).to eq('./subdir_with_1_commit')
      expect(tree.relative_path).to eq('./subdir_with_1_commit')
    end

    context 'when invoke authors command' do
      before do
        expect(repo_tree).to receive(:run).with('git shortlog -se HEAD ./subdir_with_1_commit')
                                          .and_return("\t3\tIsrael Revert <israelrevert@gmail.com>\n")
      end

      it 'parses git shortlog output to authors hash' do
        expect(repo_tree.authors).to eq([build(:author, repo: repo_tree, name: 'Israel Revert', email: 'israelrevert@gmail.com')])
      end

      it 'parses git revlist output to date sorted commits array' do
        expect(repo_tree).to receive(:run)
          .with("git rev-list --pretty=format:'%H|%at|%ai|%aE' HEAD ./subdir_with_1_commit | grep -v commit")
          .and_return('10d1814|1395407506|2014-03-21 14:11:46 +0100|israelrevert@gmail.com')
        expect(repo_tree.commits).to eq(
          [GitStats::GitData::Commit.new(repo: repo, sha: '10d1814', stamp: '1395407506',
                                         date: Time.parse('2014-03-21 14:11:46 +0100'),
                                         author: repo.authors.first! { |a| a.email == 'israelrevert@gmail.com' })]
        )
      end
    end
  end
end
