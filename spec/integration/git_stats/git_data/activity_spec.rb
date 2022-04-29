# frozen_string_literal: true

require 'integration/shared'

describe GitStats::GitData::Activity do
  include_context 'shared'

  let(:activity) { repo.activity }

  it 'counts commits by hour' do
    expect(activity.by_hour).to eq({10 => 4, 12 => 3, 13 => 1, 15 => 1, 17 => 1})
  end

  it 'counts commits by day of week' do
    expect(activity.by_wday).to eq({0 => 3, 3 => 1, 5 => 5, 6 => 1})
  end

  it 'counts commits by day of week and hour' do
    expect(activity.by_wday_hour).to eq({0 => {12 => 2, 13 => 1}, 3 => {15 => 1}, 5 => {10 => 4, 17 => 1}, 6 => {12 => 1}})
  end

  it 'counts commits by month' do
    expect(activity.by_month).to eq({10 => 10})
  end

  it 'counts commits by year' do
    expect(activity.by_year).to eq({2012 => 10})
  end

  it 'counts commits by year and month' do
    expect(activity.by_year_month).to eq({2012 => {10 => 10}})
  end
end
