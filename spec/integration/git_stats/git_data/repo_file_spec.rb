# frozen_string_literal: true

require 'integration/shared'

describe GitStats::GitData::Repo do
  include_context 'shared'

  it 'gathers all files in repo' do
    expect(repo.files.map(&:filename)).to match_array(%w(long_second.haml long.txt second.txt test2.rb test.rb test.txt))
  end

  it 'retrieves correct file content for old file' do
    commit = repo.commits.first! { |c| c.sha == 'c87ecf9c0bbdca29d73def8ed442cebf48178d92' }
    file = commit.files.first! { |f| f.filename == 'test.txt' }
    expect(file.content).to eq("bb



test
")
  end

  it 'retrieves correct file content for the newest file' do
    file = repo.files.first! { |f| f.filename == 'test.txt' }
    expect(file.content).to eq("bb

testtest

test
")
  end
end
