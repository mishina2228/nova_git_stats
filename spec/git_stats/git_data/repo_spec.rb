# frozen_string_literal: true

require 'spec_helper'

describe GitStats::GitData::Repo do
  let(:repo) { build(:repo) }

  describe 'git output parsing' do
    context 'when invoke authors command' do
      before do
        expect(repo).to receive(:run).with('git shortlog -se HEAD .').and_return("   156	John Doe <john.doe@gmail.com>
    53	Joe Doe <joe.doe@gmail.com>
")
      end

      it 'parses git shortlog output to authors hash' do
        expected = [
          build(:author, repo: repo, name: 'John Doe', email: 'john.doe@gmail.com'),
          build(:author, repo: repo, name: 'Joe Doe', email: 'joe.doe@gmail.com')
        ]
        expect(repo.authors).to eq(expected)
      end

      it 'parses git revlist output to date sorted commits array' do
        expect(repo).to receive(:run).with("git rev-list --pretty=format:'%H|%at|%ai|%aE' HEAD . | grep -v commit").and_return(
          "e4412c3|1348603824|2012-09-25 22:10:24 +0200|john.doe@gmail.com
ce34874|1347482927|2012-09-12 22:48:47 +0200|joe.doe@gmail.com
5eab339|1345835073|2012-08-24 21:04:33 +0200|john.doe@gmail.com
"
        )

        expected_commits = [
          GitStats::GitData::Commit.new(
            repo: repo, sha: '5eab339', stamp: '1345835073', date: DateTime.parse('2012-08-24 21:04:33 +0200'),
            author: repo.authors.first! { |a| a.email == 'john.doe@gmail.com' }
          ),
          GitStats::GitData::Commit.new(
            repo: repo, sha: 'ce34874', stamp: '1347482927', date: DateTime.parse('2012-09-12 22:48:47 +0200'),
            author: repo.authors.first! { |a| a.email == 'joe.doe@gmail.com' }
          ),
          GitStats::GitData::Commit.new(
            repo: repo, sha: 'e4412c3', stamp: '1348603824', date: DateTime.parse('2012-09-25 22:10:24 +0200'),
            author: repo.authors.first! { |a| a.email == 'john.doe@gmail.com' }
          )
        ]
        expect(repo.commits).to eq(expected_commits)
      end
    end

    it 'parses git rev-parse command to project version' do
      expect(repo).to receive(:run).with('git rev-parse HEAD').and_return('xyz')
      expect(repo.project_version).to eq('xyz')
    end
  end
end
