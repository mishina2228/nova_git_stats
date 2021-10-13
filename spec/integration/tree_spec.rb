require 'integration/shared'

describe GitStats::GitData::Tree do
  include_context 'tree'

  it 'gathers all authors' do
    expect(repo.authors).to match_array(expected_authors)
  end

  it 'calculates correct commits period' do
    expect(repo.commits_period).to eq([DateTime.parse('2014-03-21 14:11:46 +0100'),
                                       DateTime.parse('2014-03-21 14:12:47 +0100')])
  end

  it 'gathers all commits sorted by date' do
    expected = %w(
      10d1814b1c4acf1496ba76d40ee4954a2e3908fb
      435e0ef41e7c4917e4ba635bb44c7d36c5c7b7ad
      5fd0f5ea90e0ef34a0214ec9c170728913525ff4
    )
    expect(repo.commits.map(&:sha)).to match_array(expected)
  end

  it 'returns project name from dir' do
    expect(repo.project_name).to eq('test_repo_tree')
  end

  it 'returns project version as last commit hash' do
    expect(repo.project_version).to eq('5fd0f5ea90e0ef34a0214ec9c170728913525ff4')
  end

  it 'counts files in repo' do
    expect(repo.files_count).to eq(4)
  end

  it 'counts files by date' do
    repo.files_count_by_date.keys == (commit_dates_with_empty.zip [2, 3, 4]).to_h
  end

  it 'counts lines by date' do
    repo.files_count_by_date.values == (commit_dates_with_empty.zip [1, 2, 2]).to_h
  end

  it 'counts all lines in repo' do
    expect(repo.lines_count).to eq(0)
  end

  it 'counts files by extension in repo' do
    expect(repo.files_by_extension_count).to eq({'' => 4})
  end

  it 'counts lines by extension in repo' do
    expect(repo.lines_by_extension).to eq({})
  end

  it 'counts commits_count_by_author' do
    expect(repo.commits_count_by_author.keys).to eq(expected_authors)
    expect(repo.commits_count_by_author.values).to eq([3])
  end

  it 'counts lines_added_by_author' do
    expect(repo.insertions_by_author.keys).to eq(expected_authors)
    expect(repo.insertions_by_author.values).to eq([0])
  end

  it 'counts lines_deleted_by_author' do
    expect(repo.deletions_by_author.keys).to eq(expected_authors)
    expect(repo.deletions_by_author.values).to eq([0])
  end
end

describe GitStats::GitData::Tree do
  include_context 'tree_subdir_with_1_commit'

  it 'gathers all authors' do
    expect(repo.authors).to match_array(expected_authors)
  end

  it 'calculates correct commits period' do
    expect(repo.commits_period).to eq([DateTime.parse('2014-03-21 14:11:46 +0100'),
                                       DateTime.parse('2014-03-21 14:11:46 +0100')])
  end

  it 'gathers all commits sorted by date' do
    expect(repo.commits.map(&:sha)).to match_array(%w(10d1814b1c4acf1496ba76d40ee4954a2e3908fb))
  end

  it 'returns project name from dir' do
    expect(repo.project_name).to eq('test_repo_tree/subdir_with_1_commit')
  end

  it 'returns project version as last commit hash' do
    expect(repo.project_version).to eq('5fd0f5ea90e0ef34a0214ec9c170728913525ff4')
  end

  it 'counts files in repo' do
    expect(repo.files_count).to eq(2)
  end

  it 'counts files by date' do
    repo.files_count_by_date.keys == (commit_dates_with_empty.zip [2]).to_h
  end

  it 'counts lines by date' do
    repo.files_count_by_date.values == (commit_dates_with_empty.zip [1]).to_h
  end

  it 'counts all lines in repo' do
    expect(repo.lines_count).to eq(0)
  end

  it 'counts files by extension in repo' do
    expect(repo.files_by_extension_count).to eq({'' => 2})
  end

  it 'counts lines by extension in repo' do
    expect(repo.lines_by_extension).to eq({})
  end

  it 'counts commits_count_by_author' do
    expect(repo.commits_count_by_author.keys).to eq(expected_authors)
    expect(repo.commits_count_by_author.values).to eq([1])
  end

  it 'counts lines_added_by_author' do
    expect(repo.insertions_by_author.keys).to eq(expected_authors)
    expect(repo.insertions_by_author.values).to eq([0])
  end

  it 'counts lines_deleted_by_author' do
    expect(repo.deletions_by_author.keys).to eq(expected_authors)
    expect(repo.deletions_by_author.values).to eq([0])
  end
end

describe GitStats::GitData::Tree do
  include_context 'tree_subdir_with_2_commit'

  it 'gathers all authors' do
    expect(repo.authors).to match_array(expected_authors)
  end

  it 'calculates correct commits period' do
    expect(repo.commits_period).to eq([DateTime.parse('2014-03-21 14:12:23 +0100'),
                                       DateTime.parse('2014-03-21 14:12:47 +0100')])
  end

  it 'gathers all commits sorted by date' do
    expected = %w(
      435e0ef41e7c4917e4ba635bb44c7d36c5c7b7ad
      5fd0f5ea90e0ef34a0214ec9c170728913525ff4
    )
    expect(repo.commits.map(&:sha)).to match_array(expected)
  end

  it 'returns project name from dir' do
    expect(repo.project_name).to eq('test_repo_tree/subdir_with_2_commits')
  end

  it 'returns project version as last commit hash' do
    expect(repo.project_version).to eq('5fd0f5ea90e0ef34a0214ec9c170728913525ff4')
  end

  it 'counts files in repo' do
    expect(repo.files_count).to eq(2)
  end

  it 'counts files by date' do
    repo.files_count_by_date.keys == (commit_dates_with_empty.zip [1, 2]).to_h
  end

  it 'counts lines by date' do
    repo.files_count_by_date.values == (commit_dates_with_empty.zip [2, 2]).to_h
  end

  it 'counts all lines in repo' do
    expect(repo.lines_count).to eq(0)
  end

  it 'counts files by extension in repo' do
    expect(repo.files_by_extension_count).to eq({'' => 2})
  end

  it 'counts lines by extension in repo' do
    expect(repo.lines_by_extension).to eq({})
  end

  it 'counts commits_count_by_author' do
    expect(repo.commits_count_by_author.keys).to eq(expected_authors)
    expect(repo.commits_count_by_author.values).to eq([2])
  end

  it 'counts lines_added_by_author' do
    expect(repo.insertions_by_author.keys).to eq(expected_authors)
    expect(repo.insertions_by_author.values).to eq([0])
  end

  it 'counts lines_deleted_by_author' do
    expect(repo.deletions_by_author.keys).to eq(expected_authors)
    expect(repo.deletions_by_author.values).to eq([0])
  end
end
