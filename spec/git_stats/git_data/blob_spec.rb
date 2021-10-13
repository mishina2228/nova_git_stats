require 'spec_helper'

describe GitStats::GitData::Blob do
  let(:repo) { double }
  let(:png_blob) { described_class.new(filename: 'abc.png', sha: 'hash_png', repo: repo) }
  let(:txt_blob) { described_class.new(filename: 'abc.txt', sha: 'hash_txt', repo: repo) }

  it 'returns 0 as lines count when files is binary' do
    expect(png_blob).to receive(:binary?).and_return true
    expect(png_blob.lines_count).to eq(0)
  end

  it 'returns actual lines count when files is not binary' do
    expect(txt_blob).to receive(:binary?).and_return false
    expect(repo).to receive(:run).with('git cat-file blob hash_txt | wc -l').and_return 42
    expect(txt_blob.lines_count).to eq(42)
  end

  it 'invokes grep to check if file is binary' do
    expect(repo).to receive(:run).with("git cat-file blob hash_png | grep -m 1 '^'").and_return 'Binary file matches'
    expect(png_blob).to be_binary
  end
end
