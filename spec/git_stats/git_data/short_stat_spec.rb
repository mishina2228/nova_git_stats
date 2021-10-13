require 'spec_helper'

describe GitStats::GitData::ShortStat do
  let(:commit) { build(:commit, sha: 'abc') }

  describe 'git output parsing' do
    context 'when parse git show output' do
      [
        {content: '2 files changed, 17 insertions(+), 3 deletions(-)', expect: [2, 17, 3]},
        {content: '1 file changed, 1 insertion(+), 1 deletion(-)', expect: [1, 1, 1]},
        {content: '2 files changed, 3 deletions(-)', expect: [2, 0, 3]},
        {content: '2 files changed, 5 insertions(+)', expect: [2, 5, 0]},
        {content: '', expect: [0, 0, 0]}
      ].each do |test|
        it "#{test[:content]} parsing" do
          expect(commit.repo).to receive(:run).with('git show --shortstat --oneline --no-renames abc -- .')
                                              .and_return("abc some commit\n#{test[:content]}")

          expect(commit.short_stat).to be_a(described_class)
          expect(commit.short_stat.files_changed).to eq(test[:expect][0])
          expect(commit.short_stat.insertions).to eq(test[:expect][1])
          expect(commit.short_stat.deletions).to eq(test[:expect][2])
        end
      end
    end
  end
end
