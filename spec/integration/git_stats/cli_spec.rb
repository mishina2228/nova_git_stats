# frozen_string_literal: true

require 'spec_helper'
require 'git_stats/cli'

describe GitStats::CLI do
  after do
    FileUtils.rm_r(Dir.glob('./tmp/test_repo_tree'))
  end

  describe '#generate' do
    let(:default_option) { ['generate', '-p', build(:test_repo_tree).path, '-o', './tmp/test_repo_tree'] }

    context 'when --tree-path is not passed' do
      it 'generates statistics for the complete git repository' do
        expect { described_class.start(default_option) }
          .to output(/git shortlog -se HEAD \./).to_stdout
      end
    end

    context 'when --tree-path is passed' do
      it 'generates statistics for a given tree' do
        expect { described_class.start(default_option + ['--tree-path=subdir_with_1_commit']) }
          .to output(/git shortlog -se HEAD subdir_with_1_commit/).to_stdout
      end
    end

    context 'when -d is passed' do
      it 'generates statistics for a given tree' do
        expect { described_class.start(default_option + %w(-d subdir_with_1_commit)) }
          .to output(/git shortlog -se HEAD subdir_with_1_commit/).to_stdout
      end
    end

    context 'when --tree-path is passed with invalid tree' do
      it 'raises an exception' do
        expect { described_class.start(default_option + ['--tree-path=invalid_path']) }
          .to output(/git shortlog -se HEAD invalid_path/).to_stdout
          .and output(/fatal: ambiguous argument 'invalid_path'/).to_stderr_from_any_process
          .and raise_error(StandardError)
      end
    end

    context 'when -d is passed with invalid tree' do
      it 'raises an exception' do
        expect { described_class.start(default_option + %w(-d invalid_path)) }
          .to output(/git shortlog -se HEAD invalid_path/).to_stdout
          .and output(/fatal: ambiguous argument 'invalid_path'/).to_stderr_from_any_process
          .and raise_error(StandardError)
      end
    end

    context 'when --silent is passed' do
      it 'does not output anything' do
        expect { described_class.start(default_option + ['--silent']) }.not_to output.to_stdout
      end
    end

    context 'when -s is passed' do
      it 'does not output anything' do
        expect { described_class.start(default_option + ['-s']) }.not_to output.to_stdout
      end
    end
  end

  describe '#version' do
    context 'when version is passed' do
      it 'shows the version of this library' do
        expect { described_class.start(['version']) }
          .to output("NovaGitStats #{GitStats::VERSION}\n").to_stdout
      end
    end

    context 'when --version is passed' do
      it 'shows the version of this library' do
        expect { described_class.start(['--version']) }
          .to output("NovaGitStats #{GitStats::VERSION}\n").to_stdout
      end
    end

    context 'when -v is passed' do
      it 'shows the version of this library' do
        expect { described_class.start(['-v']) }
          .to output("NovaGitStats #{GitStats::VERSION}\n").to_stdout
      end
    end
  end
end
