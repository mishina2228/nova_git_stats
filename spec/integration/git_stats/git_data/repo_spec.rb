require 'integration/shared'

describe GitStats::GitData::Repo do
  include_context "shared"

  it 'gathers all authors' do
    expect(repo.authors).to match_array(expected_authors)
  end

  it 'calculates correct commits period' do
    expect(repo.commits_period).to eq([DateTime.parse('2012-10-19 10:44:34 +0200'),
                                       DateTime.parse('2012-10-26 17:05:25 +0200')])
  end

  it 'gathers all commits sorted by date' do
    expected = %w(
      2c11f5e5224dd7d2fab27de0fca2a9a1d0ca4038
      4e7d0e9e58e27e33d47f94faf4079a49a75931da
      81e8bef75eaa93d772f2ce11d2a266ada1292741
      872955c3a6a4be4d7ae9b2dd4bea659979f0b457
      ab47ef832c59837afcb626bfe22f0b8f0dc3717e
      b3b4f819041eb66922abe79ee2513d5ddfb64691
      b621a5df78e2953a040128191e47a24be9514b5c
      c87ecf9c0bbdca29d73def8ed442cebf48178d92
      d60b5eccf4513621bdbd65f408a0d28ff6fa9f5b
      fd66657521139b1af6fde2927c4a383ecd6508fa
    )
    expect(repo.commits.map(&:sha)).to match_array(expected)
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
    repo.files_count_by_date.keys == (commit_dates_with_empty.zip [1, 2, 2, 3, 3, 4, 5, 5, 6, 6]).to_h
  end

  it 'counts lines by date' do
    repo.files_count_by_date.values == (commit_dates_with_empty.zip [1, 2, 2, 3, 3, 4, 5, 5, 6, 6]).to_h
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
