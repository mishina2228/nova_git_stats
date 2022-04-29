# frozen_string_literal: true

require 'spec_helper'

describe GitStats::GitData::Commit do
  let(:commit) { build(:commit, sha: 'abc') }

  describe 'git output parsing' do
    context 'when parse git ls-tree output' do
      before do
        expected = <<~STDOUT
          100644 blob 5ade7ad51a75ee7db4eb06cecd3918d38134087d	lib/git_stats/git_data/commit.rb
          100644 blob db01e94677a8f72289848e507a52a43de2ea109a	lib/git_stats/git_data/repo.rb
          100644 blob 1463eacb3ac9f95f21f360f1eb935a84a9ee0895	templates/index.haml
          100644 blob 31d8b960a67f195bdedaaf9e7aa70b2389f3f1a8	templates/assets/bootstrap/css/bootstrap.min.css
        STDOUT
        expect(commit.repo).to receive(:run).with('git ls-tree -r abc -- .').and_return(expected)
      end

      it 'is parsed to files' do
        expected = [
          GitStats::GitData::Blob.new(repo: commit.repo, sha: '5ade7ad51a75ee7db4eb06cecd3918d38134087d',
                                      filename: 'lib/git_stats/git_data/commit.rb'),
          GitStats::GitData::Blob.new(repo: commit.repo, sha: 'db01e94677a8f72289848e507a52a43de2ea109a',
                                      filename: 'lib/git_stats/git_data/repo.rb'),
          GitStats::GitData::Blob.new(repo: commit.repo, sha: '1463eacb3ac9f95f21f360f1eb935a84a9ee0895',
                                      filename: 'templates/index.haml'),
          GitStats::GitData::Blob.new(repo: commit.repo, sha: '31d8b960a67f195bdedaaf9e7aa70b2389f3f1a8',
                                      filename: 'templates/assets/bootstrap/css/bootstrap.min.css')
        ]
        expect(commit.files).to eq(expected)
      end

      it 'groups files by extension' do
        expected = {'.rb' => [
          GitStats::GitData::Blob.new(repo: commit.repo, sha: '5ade7ad51a75ee7db4eb06cecd3918d38134087d',
                                      filename: 'lib/git_stats/git_data/commit.rb'),
          GitStats::GitData::Blob.new(repo: commit.repo, sha: 'db01e94677a8f72289848e507a52a43de2ea109a',
                                      filename: 'lib/git_stats/git_data/repo.rb')
        ], '.haml' => [
          GitStats::GitData::Blob.new(repo: commit.repo, sha: '1463eacb3ac9f95f21f360f1eb935a84a9ee0895',
                                      filename: 'templates/index.haml')
        ], '.css' => [
          GitStats::GitData::Blob.new(repo: commit.repo, sha: '31d8b960a67f195bdedaaf9e7aa70b2389f3f1a8',
                                      filename: 'templates/assets/bootstrap/css/bootstrap.min.css')
        ]}
        expect(commit.files_by_extension).to eq(expected)
      end

      it 'counts lines by extension excluding empty or binary files' do
        expect(GitStats::GitData::Blob).to receive(:new).and_return(
          double(lines_count: 40, extension: '.rb'),
          double(lines_count: 60, extension: '.rb'),
          double(lines_count: 0, extension: '.haml'),
          double(lines_count: 20, extension: '.css')
        )
        expect(commit.lines_by_extension).to eq({'.rb' => 100, '.css' => 20})
      end
    end
  end
end
