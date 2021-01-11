require 'spec_helper'

describe GitStats::GitData::Author do
  let(:repo) { build(:repo) }
  let(:author) { build(:author, repo: repo) }
  let(:other_author) { build(:author, repo: repo) }
  let(:my_commits) { Array.new(10) { |i| double("my_commit #{i}", author: author, short_stat: double("my_short_stat #{i}", insertions: 5, deletions: 10)) } }
  let(:other_commits) { Array.new(10) { |i| double("other_commit #{i}", author: other_author) } }

  before { repo.stub(commits: my_commits + other_commits) }

  it 'commits should give repo commits filtered to this author' do
    author.commits.should == my_commits
  end

  it 'counts lines added from short stat' do
    author.insertions.should == 50
  end

  it 'counts lines deleted from short stat' do
    author.deletions.should == 100
  end
end
