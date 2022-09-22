# frozen_string_literal: true

require 'spec_helper'

shared_context 'shared' do
  let(:repo) { build(:test_repo, last_commit_sha: '872955c') }
  let(:commit_dates) do
    [
      Time.parse('2012-10-19 10:44:34 +0200'),
      Time.parse('2012-10-19 10:46:10 +0200'),
      Time.parse('2012-10-19 10:46:56 +0200'),
      Time.parse('2012-10-19 10:47:35 +0200'),
      Time.parse('2012-10-20 12:49:02 +0200'),
      Time.parse('2012-10-21 12:49:02 +0200'),
      Time.parse('2012-10-21 12:54:02 +0200'),
      Time.parse('2012-10-21 13:20:00 +0200'),
      Time.parse('2012-10-24 15:49:02 +0200'),
      Time.parse('2012-10-26 17:05:25 +0200')
    ]
  end
  let(:tg_commit_dates) do
    [
      Time.parse('2012-10-19 10:44:34 +0200'),
      Time.parse('2012-10-19 10:46:10 +0200'),
      Time.parse('2012-10-19 10:46:56 +0200'),
      Time.parse('2012-10-19 10:47:35 +0200'),
      Time.parse('2012-10-20 12:49:02 +0200'),
      Time.parse('2012-10-21 12:49:02 +0200'),
      Time.parse('2012-10-21 13:20:00 +0200'),
      Time.parse('2012-10-26 17:05:25 +0200')
    ]
  end
  let(:jd_commit_dates) do
    [
      Time.parse('2012-10-21 12:54:02 +0200'),
      Time.parse('2012-10-24 15:49:02 +0200')
    ]
  end

  let(:expected_authors) do
    [
      build(:author, repo: repo, name: 'Tomasz Gieniusz', email: 'tomasz.gieniusz@gmail.com'),
      build(:author, repo: repo, name: 'John Doe', email: 'john.doe@gmail.com')
    ]
  end
end

shared_context 'tree_subdir_with_1_commit' do
  let(:repo) { build(:test_repo_tree, last_commit_sha: 'HEAD', tree_path: './subdir_with_1_commit') }
  let(:commit_dates) do
    [
      Time.parse('2014-03-21 14:11:46 +0100'),
      Time.parse('2014-03-21 14:12:23 +0100'),
      Time.parse('2014-03-21 14:12:47 +0100')
    ]
  end
  let(:tg_commit_dates) do
    [
      Time.parse('2014-03-21 14:11:46 +0100'),
      Time.parse('2014-03-21 14:12:23 +0100'),
      Time.parse('2014-03-21 14:12:47 +0100')
    ]
  end
  let(:jd_commit_dates) do
    [
      Time.parse('2014-03-21 14:11:46 +0100'),
      Time.parse('2014-03-21 14:12:23 +0100'),
      Time.parse('2014-03-21 14:12:47 +0100')
    ]
  end

  let(:expected_authors) do
    [
      build(:author, repo: repo, name: 'Israel Revert', email: 'israelrevert@gmail.com')
    ]
  end
end

shared_context 'tree_subdir_with_2_commit' do
  let(:repo) { build(:test_repo_tree, last_commit_sha: 'HEAD', tree_path: './subdir_with_2_commits') }
  let(:commit_dates) do
    [
      Time.parse('2014-03-21 14:11:46 +0100'),
      Time.parse('2014-03-21 14:12:23 +0100'),
      Time.parse('2014-03-21 14:12:47 +0100')
    ]
  end
  let(:tg_commit_dates) do
    [
      Time.parse('2014-03-21 14:11:46 +0100'),
      Time.parse('2014-03-21 14:12:23 +0100'),
      Time.parse('2014-03-21 14:12:47 +0100')
    ]
  end
  let(:jd_commit_dates) do
    [
      Time.parse('2014-03-21 14:11:46 +0100'),
      Time.parse('2014-03-21 14:12:23 +0100'),
      Time.parse('2014-03-21 14:12:47 +0100')
    ]
  end

  let(:expected_authors) do
    [
      build(:author, repo: repo, name: 'Israel Revert', email: 'israelrevert@gmail.com')
    ]
  end
end

# 5fd0f5e|1395407567|2014-03-21 14:12:47 +0100|israelrevert@gmail.com
# 435e0ef|1395407543|2014-03-21 14:12:23 +0100|israelrevert@gmail.com
# 10d1814|1395407506|2014-03-21 14:11:46 +0100|israelrevert@gmail.com

shared_context 'tree' do
  let(:repo) { build(:test_repo_tree, last_commit_sha: 'HEAD') }
  let(:commit_dates) do
    [
      Time.parse('2014-03-21 14:11:46 +0100'),
      Time.parse('2014-03-21 14:12:23 +0100'),
      Time.parse('2014-03-21 14:12:47 +0100')
    ]
  end
  let(:tg_commit_dates) do
    [
      Time.parse('2014-03-21 14:11:46 +0100'),
      Time.parse('2014-03-21 14:12:23 +0100'),
      Time.parse('2014-03-21 14:12:47 +0100')
    ]
  end
  let(:jd_commit_dates) do
    [
      Time.parse('2014-03-21 14:11:46 +0100'),
      Time.parse('2014-03-21 14:12:23 +0100'),
      Time.parse('2014-03-21 14:12:47 +0100')
    ]
  end

  let(:expected_authors) do
    [
      build(:author, repo: repo, name: 'Israel Revert', email: 'israelrevert@gmail.com')
    ]
  end
end
