# frozen_string_literal: true

require 'spec_helper'

describe GitStats::GitData::Author do
  let(:repo) { build(:repo) }
  let(:author) { build(:author, repo: repo) }
  let(:other_author) { build(:author, repo: repo) }
  let(:my_commits) do
    Array.new(10) do |i|
      double("my_commit #{i}", author: author, short_stat: double("my_short_stat #{i}", insertions: 5, deletions: 10))
    end
  end
  let(:other_commits) { Array.new(10) { |i| double("other_commit #{i}", author: other_author) } }

  before { allow(repo).to receive_messages(commits: my_commits + other_commits) }

  it 'commits should give repo commits filtered to this author' do
    expect(author.commits).to eq(my_commits)
  end

  it 'counts lines added from short stat' do
    expect(author.insertions).to eq(50)
  end

  it 'counts lines deleted from short stat' do
    expect(author.deletions).to eq(100)
  end

  describe '#commits_sum' # TODO
  describe '#changed_lines' # TODO
  describe '#commits_sum_by_date' # TODO
  describe '#total_insertions_by_date' # TODO
  describe '#total_deletions_by_date' # TODO
  describe '#total_changed_lines_by_date' # TODO
  describe '#insertions_by_date' # TODO
  describe '#deletions_by_date' # TODO
  describe '#changed_lines_by_date' # TODO
end
