# frozen_string_literal: true

require 'integration/shared'

describe GitStats::GitData::Repo do
  include_context 'shared'

  it 'gathers all authors' do
    expect(repo.authors).to match_array(expected_authors)
  end

  it 'calculates correct commits period' do
    expect(repo.commits_period).to eq([Time.parse('2012-10-19 10:44:34 +0200'),
                                       Time.parse('2012-10-26 17:05:25 +0200')])
  end

  it 'gathers all commits sorted by date in ascending order' do
    expected = %w(
      b3b4f819041eb66922abe79ee2513d5ddfb64691
      d60b5eccf4513621bdbd65f408a0d28ff6fa9f5b
      ab47ef832c59837afcb626bfe22f0b8f0dc3717e
      2c11f5e5224dd7d2fab27de0fca2a9a1d0ca4038
      c87ecf9c0bbdca29d73def8ed442cebf48178d92
      b621a5df78e2953a040128191e47a24be9514b5c
      fd66657521139b1af6fde2927c4a383ecd6508fa
      4e7d0e9e58e27e33d47f94faf4079a49a75931da
      81e8bef75eaa93d772f2ce11d2a266ada1292741
      872955c3a6a4be4d7ae9b2dd4bea659979f0b457
    )
    expect(repo.commits.map(&:sha)).to eq(expected)
  end

  it 'returns project name from dir' do
    expect(repo.project_name).to eq('test_repo')
  end

  it 'returns project version as last commit hash' do
    expect(repo.project_version).to eq('872955c3a6a4be4d7ae9b2dd4bea659979f0b457')
  end

  it 'counts files in repo' do
    expect(repo.files_count).to eq(6)
  end

  it 'counts files by date' do
    # Files count by date
    # 2012-10-19 => 3 (+3)
    # 2012-10-20 => 3 (+0)
    # 2012-10-21 => 5 (+2)
    # 2012-10-24 => 6 (+1)
    # 2012-10-26 => 6 (+0)
    uniq_commit_dates = commit_dates.map(&:to_date).uniq
    expect(repo.files_count_by_date).to eq((uniq_commit_dates.zip [3, 3, 5, 6, 6]).to_h)
  end

  it 'counts lines by date' do
    # Lines count by date
    # 2012-10-19 => 11 (+11)
    # 2012-10-20 => 11 (+0)
    # 2012-10-21 => 1014 (+1003)
    # 2012-10-24 => 1114 (+100)
    # 2012-10-26 => 1114 (+0)
    uniq_commit_dates = commit_dates.map(&:to_date).uniq
    expect(repo.lines_count_by_date).to eq((uniq_commit_dates.zip [11, 11, 1014, 1114, 1114]).to_h)
  end

  it 'counts all lines in repo' do
    expect(repo.lines_count).to eq(1114)
  end

  it 'counts files by extension in repo' do
    expect(repo.files_by_extension_count).to eq({'.haml' => 1, '.txt' => 3, '.rb' => 2})
  end

  it 'counts lines by extension in repo' do
    expect(repo.lines_by_extension).to eq({'.haml' => 100, '.txt' => 1008, '.rb' => 6})
  end

  it 'counts commits_count_by_author' do
    expect(repo.commits_count_by_author.keys).to eq(expected_authors)
    expect(repo.commits_count_by_author.values).to eq([8, 2])
  end

  it 'counts lines_added_by_author' do
    expect(repo.insertions_by_author.keys).to eq(expected_authors)
    expect(repo.insertions_by_author.values).to eq([1021, 103])
  end

  it 'counts lines_deleted_by_author' do
    expect(repo.deletions_by_author.keys).to eq(expected_authors)
    expect(repo.deletions_by_author.values).to eq([10, 0])
  end
end
