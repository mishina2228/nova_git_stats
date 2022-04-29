# frozen_string_literal: true

require 'spec_helper'

describe GitStats::CommandRunner do
  let(:command_runner) { described_class.new }

  describe '#run' do
    context 'when arguments are valid' do
      it 'executes a command at the specified path' do
        expect(command_runner.run('.', 'echo test')).to eq("test\n")
      end
    end
  end
end
