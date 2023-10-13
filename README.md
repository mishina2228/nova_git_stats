# NovaGitStats

[![Gem Version](https://badge.fury.io/rb/nova_git_stats.svg)](https://badge.fury.io/rb/nova_git_stats)
![CI](https://github.com/mishina2228/nova_git_stats/workflows/CI/badge.svg)
[![Documentation](https://img.shields.io/badge/docs-rubydoc.info-blue.svg)](https://rubydoc.info/gems/nova_git_stats)
[![Maintainability](https://api.codeclimate.com/v1/badges/118cce63cc58fef4ae47/maintainability)](https://codeclimate.com/github/mishina2228/git_stats/maintainability)
[![codecov](https://codecov.io/gh/mishina2228/nova_git_stats/branch/master/graph/badge.svg?token=532RLO5L7A)](https://codecov.io/gh/mishina2228/nova_git_stats)

**This project is forked from original [tomgi/git-stats](https://github.com/tomgi/git_stats).**

NovaGitStats is a git repository statistics generator.
It browses the repository and outputs html page with statistics.

## Examples

* [Bootstrap](https://mishina2228.github.io/nova_git_stats_sample/bootstrap/)
* [Devise](https://mishina2228.github.io/nova_git_stats_sample/devise/)
* [DeviseInvitable](https://mishina2228.github.io/nova_git_stats_sample/devise_invitable/)
* [John](https://mishina2228.github.io/nova_git_stats_sample/john/)
* [jQuery](https://mishina2228.github.io/nova_git_stats_sample/jquery/)
* [Rails](https://mishina2228.github.io/nova_git_stats_sample/rails/)
* [React](https://mishina2228.github.io/nova_git_stats_sample/react/)
* [Vue](https://mishina2228.github.io/nova_git_stats_sample/vue/)

## Installation

### Existing ruby/gem environment

    $ gem install git_stats

### debian stretch (9.*)

    # apt-get install ruby ruby-nokogiri ruby-nokogiri-diff ruby-nokogumbo
    # gem install git_stats

### Ubuntu

    $ sudo apt-get install ruby ruby-dev gcc zlib1g-dev make
    $ sudo gem install git_stats

## Prerequisites

* Git
* Ruby 2.5+

## Usage

### Generator

#### Print help

    $ git_stats
    Commands:
      git_stats generate        # Generates the statistics of a git repository
      git_stats help [COMMAND]  # Describe available commands or one specific command
      git_stats version         # Show GitStats version number and quit

#### Print help of the generate command

    $ git_stats help generate
    Usage:
      git_stats generate

    Options:
      -p, [--path=PATH]                          # Path to git repository from which statistics should be generated.
                                                 # Default: .
      -o, [--out-path=OUT_PATH]                  # Output path where statistics should be written.
                                                 # Default: ./git_stats
      -l, [--language=LANGUAGE]                  # Language of written statistics.
                                                 # Default: en
      -f, [--first-commit-sha=FIRST_COMMIT_SHA]  # Commit from where statistics should start.
      -t, [--last-commit-sha=LAST_COMMIT_SHA]    # Commit where statistics should stop.
                                                 # Default: HEAD
      -s, [--silent], [--no-silent]              # Silent mode. Don't output anything.
      -d, [--tree-path=TREE_PATH]                # Tree path of where statistics should be generated.
                                                 # Default: .
      -c, [--comment-string=COMMENT_STRING]      # The string which is used for comments.
                                                 # Default: //

    Generates the statistics of a git repository

#### Start generator with default settings

    $ git_stats generate
      git rev-list --pretty=format:'%h|%at|%ai|%aE' HEAD | grep -v commit
      git shortlog -se HEAD
      ...

#### Start generator with some parameters in long and short form

    $ git_stats generate -o stats --langugage de
      git rev-list --pretty=format:'%h|%at|%ai|%aE' HEAD | grep -v commit
      git shortlog -se HEAD
      ...

### API usage example

    > repo = GitStats::GitData::Repo.new(path: '.', first_commit_sha: 'abcd1234', last_commit_sha: 'HEAD')
    > repo.authors
    => [...]
    > repo.commits
    => [...]
    > commit.files
    => [...]

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
