# frozen_string_literal: true

require_relative 'core_extensions/hash'
require_relative 'core_extensions/symbol'
require_relative 'core_extensions/enumerable'

require_relative 'version'
require_relative 'i18n'
require_relative 'generator'
require_relative 'command_runner'
require_relative 'command_parser'

require_relative 'git_data/activity'
require_relative 'git_data/author'
require_relative 'git_data/blob'
require_relative 'git_data/commit'
require_relative 'git_data/repo'
require_relative 'git_data/short_stat'
require_relative 'git_data/comment_stat'
require_relative 'git_data/tree'

require_relative 'stats_view/template'
require_relative 'stats_view/view'
require_relative 'stats_view/view_data'

require_relative 'stats_view/charts/activity_charts'
require_relative 'stats_view/charts/authors_charts'
require_relative 'stats_view/charts/chart'
require_relative 'stats_view/charts/charts'
require_relative 'stats_view/charts/repo_charts'
