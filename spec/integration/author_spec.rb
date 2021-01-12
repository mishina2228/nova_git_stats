require 'integration/shared'

describe GitStats::GitData::Activity do
  include_context "shared"

  let(:tg) { repo.authors.first! { |a| a.email == 'tomasz.gieniusz@gmail.com' } }
  let(:jd) { repo.authors.first! { |a| a.email == 'john.doe@gmail.com' } }

  it 'filters commits to author' do
    expect(tg.commits.map(&:sha)).to match_array(%w(
      2c11f5e5224dd7d2fab27de0fca2a9a1d0ca4038
      4e7d0e9e58e27e33d47f94faf4079a49a75931da
      872955c3a6a4be4d7ae9b2dd4bea659979f0b457
      ab47ef832c59837afcb626bfe22f0b8f0dc3717e
      b3b4f819041eb66922abe79ee2513d5ddfb64691
      b621a5df78e2953a040128191e47a24be9514b5c
      c87ecf9c0bbdca29d73def8ed442cebf48178d92
      d60b5eccf4513621bdbd65f408a0d28ff6fa9f5b
    ))
    expect(jd.commits.map(&:sha)).to match_array(%w(fd66657521139b1af6fde2927c4a383ecd6508fa 81e8bef75eaa93d772f2ce11d2a266ada1292741))
  end

  context 'activity' do
    it 'counts commits by hour' do
      expect(tg.activity.by_hour).to eq({10 => 4, 12 => 2, 13 => 1, 17 => 1})
      expect(jd.activity.by_hour).to eq({12 => 1, 15 => 1})
    end

    it 'counts commits by day of week' do
      expect(tg.activity.by_wday).to eq({0 => 2, 5 => 5, 6 => 1})
      expect(jd.activity.by_wday).to eq({0 => 1, 3 => 1})
    end

    it 'counts commits by day of week and hour' do
      expect(tg.activity.by_wday_hour).to eq({0 => {12 => 1, 13 => 1}, 5 => {10 => 4, 17 => 1}, 6 => {12 => 1}})
      expect(jd.activity.by_wday_hour).to eq({0 => {12 => 1}, 3 => {15 => 1}})
    end

    it 'counts commits by month' do
      expect(tg.activity.by_month).to eq({10 => 8})
      expect(jd.activity.by_month).to eq({10 => 2})
    end

    it 'counts commits by year' do
      expect(tg.activity.by_year).to eq({2012 => 8})
      expect(jd.activity.by_year).to eq({2012 => 2})
    end

    it 'counts commits by year and month' do
      expect(tg.activity.by_year_month).to eq({2012 => {10 => 8}})
      expect(jd.activity.by_year_month).to eq({2012 => {10 => 2}})
    end

    it 'counts commits_sum_by_date' do
      expect(tg.commits_sum_by_date.map { |d, _s| d }).to eq(tg_commit_dates)
      expect(tg.commits_sum_by_date.map { |_d, s| s }).to eq([1, 2, 3, 4, 5, 6, 7, 8])
      expect(jd.commits_sum_by_date.map { |d, _s| d }).to eq(jd_commit_dates)
      expect(jd.commits_sum_by_date.map { |_d, s| s }).to eq([1, 2])
    end

    it 'counts insertions_by_date' do
      expect(tg.insertions_by_date.map { |d, _s| d }).to eq(tg_commit_dates)
      expect(tg.insertions_by_date.map { |_d, s| s }).to eq([4, 9, 14, 15, 20, 1020, 1021, 1021])
      expect(jd.insertions_by_date.map { |d, _s| d }).to eq(jd_commit_dates)
      expect(jd.insertions_by_date.map { |_d, s| s }).to eq([3, 103])
    end

    it 'counts deletions_by_date' do
      expect(tg.deletions_by_date.map { |d, _s| d }).to eq(tg_commit_dates)
      expect(tg.deletions_by_date.map { |_d, s| s }).to eq([0, 0, 4, 4, 9, 9, 10, 10])
      expect(jd.deletions_by_date.map { |d, _s| d }).to eq(jd_commit_dates)
      expect(jd.deletions_by_date.map { |_d, s| s }).to eq([0, 0])
    end
  end
end
