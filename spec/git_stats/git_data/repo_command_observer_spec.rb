# frozen_string_literal: true

require 'spec_helper'

describe GitStats::GitData::Repo do
  let(:repo) { build(:repo) }

  describe 'command observers' do
    context 'should be invoked after every command' do
      it 'accepts block' do
        command_runner = double('command_runner')
        repo = build(:repo, command_runner: command_runner)

        observer = double('observer')
        repo.add_command_observer { |command, result| observer.invoked(command, result) }
        expect(command_runner).to receive(:run).with(repo.path, 'aa').and_return('bb')
        expect(observer).to receive(:invoked).with('aa', 'bb')

        repo.run('aa')
      end

      it 'accepts Proc' do
        command_runner = double('command_runner')
        repo = build(:repo, command_runner: command_runner)

        observer = double('observer')
        repo.add_command_observer(observer)
        expect(command_runner).to receive(:run).with(repo.path, 'aa').and_return('bb')
        expect(observer).to receive(:call).with('aa', 'bb')

        repo.run('aa')
      end
    end
  end
end
